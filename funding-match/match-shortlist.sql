-- Funding Match: monthly call shortlist (website database)
-- Up to 10 company-eligible calls per programme sector, deadline 21 to 120 days out.
with g as (
  select id, name, funder, award, deadline_parsed, deadline_kind, region, country, applicant_type, eligibility,
         consortium_required, co_funder, quality_score, weblink, email_blurb, description,
         coalesce(sector_tags,'{}') || coalesce(technology_tags,'{}') as tg
  from grants
  where active and not coalesce(is_expired,false)
    and deadline_parsed between current_date + 21 and current_date + 120
    and coalesce(review_status,'') not in ('rejected','pending')
    and weblink is not null
    and region in ('UK','Europe','Global','International')
    and (country is null or country = 'United Kingdom')
    and applicant_type ~* '(sme|company|companies|startup|enterprise)'
    and coalesce(quality_score,0) >= 80
),
s as (
  select g.*, x.sector from g cross join lateral (
    select 'AI/Semiconductors/Robotics' as sector where tg && array['Artificial Intelligence','AI & Data','Robotics','Semiconductors','Microelectronics','Machine Learning','Autonomous Systems','Industrial Automation','Deep tech & Quantum','Data Science']
    union all select 'Life Sciences' where tg && array['Life sciences & Health','Clinical Trials','Oncology','Diagnostics','Medical Devices','Digital Health','Drug Discovery','Biotechnology']
    union all select 'Defence & Dual-Use' where tg && array['Defence, Security & Space','Defence','Security and Resilience','Space Technology']
  ) x
)
select sector, id, name, funder, award, deadline_parsed, deadline_kind, region, applicant_type,
       consortium_required, co_funder, quality_score, weblink, left(coalesce(eligibility,''),400) as eligibility
from (select *, row_number() over (partition by sector order by coalesce(consortium_required,false), quality_score desc, deadline_parsed) rn from s) z
where rn <= 10
order by sector, rn;

-- Funding Match: monthly audience (one row per company: the first verified named contact)
-- Excludes suppressed contacts and domains, investors, academic/public/personal addresses.
select distinct on (lower(c.company))
       c.sector, c.company, c.company_domain, c.email, c.first_name, c.last_name, c.job_title, c.country
from contact_register c
where c.sector in ('AI/Semiconductors/Robotics','Life Sciences','Defence & Dual-Use')
  and coalesce(c.audience_type,'company') = 'company'
  and not coalesce(c.suppressed,false)
  and c.reoon_status = 'safe'
  and c.validation_status = 'verified'
  and coalesce(c.first_name,'') <> '' and coalesce(c.company,'') <> ''
  and not exists (select 1 from suppressed_emails se where lower(se.email) = lower(c.email))
  and not exists (select 1 from suppressed_domains sd where lower(sd.domain) = lower(c.email_domain))
order by lower(c.company), c.validated_at desc nulls last;
