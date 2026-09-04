-- ============================================================
-- THE WHOLE KIT, FOR EVERY AUDIENCE  ·  generated, do not hand-edit
-- _source/build_kit_sql.py + _source/kit_captions.py
--
-- Run in the Supabase SQL editor on dts-prod. Transactional, safe to re-run.
-- ORDER MATTERS and is not the obvious one:
--   1  create the sets and their captions   (assets can only fill sets that exist)
--   2  point each bucket at the right set
--   3  re-stamp people who are on the wrong set
--   4  fill the shared image bin into every ACTIVE set
--   5  verify, and count PEOPLE per set
--
-- WHY THIS EXISTS. The public page at /creative-kit updates itself when the kit
-- is rebuilt; the personal /kit?c=CODE pages read this database and do not. So
-- the two drifted, twice. Worse, the WORDS drifted from the audience: verified
-- live 2026-09-04, ordinary captains were being handed filmmaker copy and
-- ordinary supporters were being handed "I spent a long time making a film".
-- ============================================================

-- ============================================================
-- 1 · THE SETS AND THEIR VOICES
-- ============================================================
-- The image bin is shared - a frame of Dead Dawn is the same frame whoever
-- posts it. The words are never shared, because a caption puts a sentence in a
-- real person's mouth and the whole pitch is that these are real, unaffiliated
-- local people. See _source/kit_captions.py for the full reasoning.

-- makers
insert into dts_kit_asset_sets (slug, campaign_slug, title, headline, active)
values ('makers', 'silt-dead-dawn', 'Silt + Dead Dawn - cast, crew and investors', 'Save these, then post', true)
on conflict (slug) do update set title = excluded.title,
  headline = excluded.headline, active = excluded.active;

delete from dts_kit_captions where set_slug = 'makers';
insert into dts_kit_captions (set_slug, sort, kind, label, body) values
  ('makers', 10, 'post', 'The personal one - best performer', 'I spent a long time making [DEAD DAWN / SILT - pick yours]. It is finished, and instead of waiting for a distributor to decide whether you are allowed to see it, we are asking theaters directly.

Enough people in one city ask their local independent cinema, and a real programmer takes a look. That is the whole mechanism. No studio ever passed on this - we never went out.

Twenty seconds and a ZIP code: {{LINK}}'),
  ('makers', 20, 'post', 'The short one', 'A film I worked on is going to theaters with no distributor. Whether it plays anywhere near you is decided by how many people ask for it.

Twenty seconds: {{LINK}}'),
  ('makers', 30, 'post', 'The blunt one', 'I am not asking you to buy anything.

I am asking you to put your ZIP code in a box, so that an independent cinema near you sees that somebody in their city wants this film. That is the entire ask, and most people have no idea it is a thing you can do.

{{LINK}}'),
  ('makers', 40, 'dm', 'The five messages', 'Hey - the film I worked on is finally getting into theaters, and it is an audience-demand thing, so it genuinely depends on people asking. Takes twenty seconds and it would mean a lot to me: {{LINK}}');

-- captains
insert into dts_kit_asset_sets (slug, campaign_slug, title, headline, active)
values ('captains', 'silt-dead-dawn', 'Demand the Screen - captains and supporters', 'Save these, then post', true)
on conflict (slug) do update set title = excluded.title,
  headline = excluded.headline, active = excluded.active;

delete from dts_kit_captions where set_slug = 'captains';
insert into dts_kit_captions (set_slug, sort, kind, label, body) values
  ('captains', 10, 'post', 'The local one - lead with this', 'I want a real independent film to play in [YOUR CITY] again.

Two finished features are going out with no studio and no distributor. You put in your ZIP, it finds the actual independent cinema nearest you, and it writes the request to their programmer for you. Twenty seconds, costs nothing.

If enough of us here ask, a programmer looks at [YOUR CITY]. That is the whole mechanism.

{{LINK}}'),
  ('captains', 20, 'post', 'The short one', 'You can help put a movie in your local theater. That is a real thing you can do, and almost nobody knows it.

Twenty seconds and a ZIP code: {{LINK}}'),
  ('captains', 30, 'post', 'The honest one', 'This might not work, which is why I like it.

Two independent features, no studio, no distributor, going straight at theaters and asking audiences to make the case. The counts are public - including the cities that are not working.

I would rather back something running the experiment in the open.

{{LINK}}'),
  ('captains', 40, 'dm', 'The five messages', 'Hey - do you still get out to the movies? There is an independent feature trying to get booked here, and it takes about twenty seconds to put your ZIP in and add your name to the ask. No money, no signup hell. Would mean a lot if you did it: {{LINK}}');

-- ogf-2026
insert into dts_kit_asset_sets (slug, campaign_slug, title, headline, active)
values ('ogf-2026', 'silt-dead-dawn', 'One Grand Film - filmmaker audience', 'Save these, then post', true)
on conflict (slug) do update set title = excluded.title,
  headline = excluded.headline, active = excluded.active;

delete from dts_kit_captions where set_slug = 'ogf-2026';
insert into dts_kit_captions (set_slug, sort, kind, label, body) values
  ('ogf-2026', 10, 'post', 'The mechanism - lead with this', 'There is a way to get an independent cinema to book a film that has no distributor, and it is measurable.

Enough people in one city ask their local arthouse directly, and a programmer actually looks. Not a festival. Not a sales agent. Demonstrated demand, addressed to a specific theater, sent by real people from their own email.

Someone is running it in public right now with the numbers showing. Worth watching if you have a finished film sitting on a drive.

{{LINK}}'),
  ('ogf-2026', 20, 'post', 'The short one', 'A distribution experiment worth watching: independent cinemas will book a film when enough local people ask for it. Someone is testing that in public, with the counts visible. {{LINK}}'),
  ('ogf-2026', 30, 'post', 'For filmmakers with a finished film', 'If you have a finished film and no distributor, the honest problem is not quality. It is that nobody can prove an audience exists.

This is an attempt to build that proof - you put in a ZIP, it matches you to the actual independent cinema nearest you, and hands you a request addressed to that theater''s programmer.

{{LINK}}'),
  ('ogf-2026', 40, 'dm', 'The direct message', 'Hey - thought of you because of the film you finished. Someone built a way to show a theater that demand exists before asking them to book. Takes twenty seconds to see how it works: {{LINK}}');

-- 'silt-dead-dawn' is the historical default every early claimer was backfilled
-- onto. It is kept ACTIVE and turned into an alias of the makers copy, which is
-- what it always actually was. Deactivating it would return ZERO assets for
-- everyone still stamped with it, because dts_kit joins on s.active.

delete from dts_kit_captions where set_slug = 'silt-dead-dawn';
insert into dts_kit_captions (set_slug, sort, kind, label, body)
select 'silt-dead-dawn', sort, kind, label, body
  from dts_kit_captions where set_slug = 'makers';


-- ============================================================
-- 2 · ROUTING - which bucket hands out which voice
-- ============================================================
-- This is the line that was wrong, verified live against dts_kit on 2026-09-04:
--   dd-cast-7f3a -> silt-dead-dawn -> "I spent a long time making a film"
--   supporter-1b -> silt-dead-dawn -> the same, to people who made nothing
--   ogf          -> ogf-2026       -> filmmaker copy ... and dts-26.15.js line
--                   1285 read DTS_CAPTAIN_BUCKET = 'ogf', so EVERY captain who
--                   signed up on the main site landed in the OGF bucket and was
--                   handed copy written for someone with a finished feature on
--                   a hard drive.
-- Exactly two groups were getting true copy, and only by accident: real
-- cast/crew, and real One Grand Film filmmakers.

insert into dts_invite_buckets (slug, tier, label, role_note, active, asset_set) values
  ('captain', 'captain', 'Film Captain', null, true, 'captains')
on conflict (slug) do update
  set asset_set = excluded.asset_set, active = true;

update dts_invite_buckets b
   set asset_set = m.set_slug
  from (values
  ('captain', 'captains'),
  ('dd-cast-7f3a', 'makers'),
  ('ogf', 'ogf-2026'),
  ('supporter-1b', 'captains')
       ) as m(bucket, set_slug)
 where b.slug = m.bucket;


-- ============================================================
-- 3 · RE-STAMP THE PEOPLE ALREADY ON THE WRONG SET
-- ============================================================
-- asset_set is stamped at claim time and never re-resolved - deliberately, so
-- repointing a bucket cannot change a kit already in someone's hands. That is
-- the right default and it is exactly why this correction has to be explicit.
--
-- Only rows whose bucket we actually recorded can be corrected. Historical rows
-- have bucket_slug NULL (it was never stored before the August migration) and
-- are left alone: a wrong guess is worse than leaving them on the makers copy,
-- and that early group is mostly cast and crew anyway.

update dts_ambassadors a
   set asset_set = b.asset_set
  from dts_invite_buckets b
 where a.bucket_slug = b.slug
   and b.asset_set is not null
   and coalesce(a.asset_set, '') is distinct from b.asset_set;


-- ------------------------------------------------------------------
-- 3b · THE ONE THAT NEEDS YOUR DECISION, AJ  -  run it separately
-- ------------------------------------------------------------------
-- Step 3 cannot fix the biggest group, because the data cannot tell them apart.
-- Main-site captains and real One Grand Film filmmakers BOTH carry
-- bucket_slug = 'ogf' - the first because DTS_CAPTAIN_BUCKET was set to 'ogf'
-- in the bundle, the second because that is genuinely their bucket. Same row,
-- two different people.
--
-- What breaks the tie is the calendar: THE OGF BLAST HAS NOT GONE OUT YET. So
-- essentially everyone sitting on 'ogf' today arrived through the main site and
-- is not a filmmaker - they are being handed "thought of you because of the
-- film you finished".
--
-- Look at the count first:
--
--   select count(*) from dts_ambassadors where bucket_slug = 'ogf';
--
-- Then, once 26.16 is live so new captains stop landing there, move the
-- existing ones. Set the cutoff to the moment you actually send the OGF blast;
-- anyone who claims after it is a real filmmaker and must be left alone.
--
--   update dts_ambassadors
--      set asset_set = 'captains'
--    where bucket_slug = 'ogf'
--      and created_at < '2026-09-04T00:00:00Z';   -- <-- YOUR cutoff
--
-- Deliberately left commented out. It rewrites what a live person sees, and
-- that is your call, not a script's.


-- ============================================================
-- 4 · THE SHARED IMAGE BIN
-- ============================================================
-- Read off the 43 images actually published at
--   https://aaronjayrome.github.io/dts-creative-kit/images/
-- so a row cannot point at a URL that does not exist. Fills EVERY ACTIVE SET by
-- cross join rather than a list of slugs somebody has to remember to extend.

begin;

create temporary table _kit_bin (
  sort int, name text, note text, url text, width int, height int
) on commit drop;

insert into _kit_bin (sort, name, note, url, width, height) values
  (102, 'Still · Anna Beth Post Office Antlers 001', '1080 x 454', 'https://aaronjayrome.github.io/dts-creative-kit/images/still-w01-anna-beth-post-office-antlers-001.jpg', 1080, 454),
  (104, 'Still · Anna Beth Red Cu', '1080 x 455', 'https://aaronjayrome.github.io/dts-creative-kit/images/still-w01-anna-beth-red-cu.jpg', 1080, 455),
  (106, 'Still · Anna Beth Trappers 001', '1080 x 455', 'https://aaronjayrome.github.io/dts-creative-kit/images/still-w01-anna-beth-trappers-001.jpg', 1080, 455),
  (108, 'Still · Bartleby Lake 001', '1080 x 451', 'https://aaronjayrome.github.io/dts-creative-kit/images/still-w01-bartleby-lake-001.jpg', 1080, 451),
  (110, 'Still · Dawn Tesla 001', '1080 x 454', 'https://aaronjayrome.github.io/dts-creative-kit/images/still-w01-dawn-tesla-001.jpg', 1080, 454),
  (112, 'Still · Group Lake Breakfast', '1080 x 454', 'https://aaronjayrome.github.io/dts-creative-kit/images/still-w01-group-lake-breakfast.jpg', 1080, 454),
  (114, 'Still · Hadria Cheers 001', '1080 x 455', 'https://aaronjayrome.github.io/dts-creative-kit/images/still-w01-hadria-cheers-001.jpg', 1080, 455),
  (116, 'Still · Hadria Deep Focus 001', '1080 x 451', 'https://aaronjayrome.github.io/dts-creative-kit/images/still-w01-hadria-deep-focus-001.jpg', 1080, 451),
  (118, 'Still · Javier Trappers 001', '1080 x 454', 'https://aaronjayrome.github.io/dts-creative-kit/images/still-w01-javier-trappers-001.jpg', 1080, 454),
  (120, 'Still · Mike Lake 001', '1080 x 450', 'https://aaronjayrome.github.io/dts-creative-kit/images/still-w01-mike-lake-001.jpg', 1080, 450),
  (202, 'Post · 01 Hook', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/films-01-hook.jpg', 1080, 1350),
  (204, 'Post · 02 Dead Dawn Poster', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/films-02-dead-dawn-poster.jpg', 1080, 1350),
  (206, 'Post · 03 Dead Dawn Still', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/films-03-dead-dawn-still.jpg', 1080, 1350),
  (208, 'Post · 04 Dead Dawn Neon', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/films-04-dead-dawn-neon.jpg', 1080, 1350),
  (210, 'Post · 05 Silt Poster', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/films-05-silt-poster.jpg', 1080, 1350),
  (212, 'Post · 06 Silt Still', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/films-06-silt-still.jpg', 1080, 1350),
  (214, 'Post · 07 Cast', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/films-07-cast.jpg', 1080, 1350),
  (216, 'Post · 08 Cta', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/films-08-cta.jpg', 1080, 1350),
  (302, 'Post · 01 Hook', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/mission-01-hook.jpg', 1080, 1350),
  (304, 'Post · 02 The Old Way', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/mission-02-the-old-way.jpg', 1080, 1350),
  (306, 'Post · 03 Mechanism', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/mission-03-mechanism.jpg', 1080, 1350),
  (308, 'Post · 04 Proof', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/mission-04-proof.jpg', 1080, 1350),
  (310, 'Post · 05 Who', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/mission-05-who.jpg', 1080, 1350),
  (312, 'Post · 06 Cta', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/mission-06-cta.jpg', 1080, 1350),
  (402, 'Story · 01 Mission Story', '1080 x 1920', 'https://aaronjayrome.github.io/dts-creative-kit/images/stories-01-mission-story.jpg', 1080, 1920),
  (404, 'Story · 02 Films Story', '1080 x 1920', 'https://aaronjayrome.github.io/dts-creative-kit/images/stories-02-films-story.jpg', 1080, 1920),
  (406, 'Story · 03 Cta Story', '1080 x 1920', 'https://aaronjayrome.github.io/dts-creative-kit/images/stories-03-cta-story.jpg', 1080, 1920),
  (502, 'Square · 01 Mission Square', '1080 x 1080', 'https://aaronjayrome.github.io/dts-creative-kit/images/square-01-mission-square.jpg', 1080, 1080),
  (504, 'Square · 02 Films Square', '1080 x 1080', 'https://aaronjayrome.github.io/dts-creative-kit/images/square-02-films-square.jpg', 1080, 1080),
  (602, 'Behind the scenes · 01 Video Village', '1080 x 810', 'https://aaronjayrome.github.io/dts-creative-kit/images/bts-bts-01-video-village.jpg', 1080, 810),
  (604, 'Behind the scenes · 02 Camera Setup', '1080 x 1920', 'https://aaronjayrome.github.io/dts-creative-kit/images/bts-bts-02-camera-setup.jpg', 1080, 1920),
  (606, 'Behind the scenes · 03 Police Station Crew', '1080 x 608', 'https://aaronjayrome.github.io/dts-creative-kit/images/bts-bts-03-police-station-crew.jpg', 1080, 608),
  (608, 'Behind the scenes · 04 Night Fog Crew', '1080 x 1920', 'https://aaronjayrome.github.io/dts-creative-kit/images/bts-bts-04-night-fog-crew.jpg', 1080, 1920),
  (610, 'Behind the scenes · 05 Trappers Neon Night', '1080 x 566', 'https://aaronjayrome.github.io/dts-creative-kit/images/bts-bts-05-trappers-neon-night.jpg', 1080, 566),
  (612, 'Behind the scenes · 06 Slate Dead Dawn', '1080 x 608', 'https://aaronjayrome.github.io/dts-creative-kit/images/bts-bts-06-slate-dead-dawn.jpg', 1080, 608),
  (614, 'Behind the scenes · 07 Trappers Night Rig', '1080 x 745', 'https://aaronjayrome.github.io/dts-creative-kit/images/bts-bts-07-trappers-night-rig.jpg', 1080, 745),
  (616, 'Behind the scenes · 08 Camera Dolly Bar', '1080 x 1920', 'https://aaronjayrome.github.io/dts-creative-kit/images/bts-bts-08-camera-dolly-bar.jpg', 1080, 1920),
  (618, 'Behind the scenes · 09 Arri Rig', '1080 x 810', 'https://aaronjayrome.github.io/dts-creative-kit/images/bts-bts-09-arri-rig.jpg', 1080, 810),
  (620, 'Behind the scenes · 10 Crew On Set', '1080 x 810', 'https://aaronjayrome.github.io/dts-creative-kit/images/bts-bts-10-crew-on-set.jpg', 1080, 810),
  (622, 'Behind the scenes · 11 Deer And Camera', '1080 x 608', 'https://aaronjayrome.github.io/dts-creative-kit/images/bts-bts-11-deer-and-camera.jpg', 1080, 608),
  (702, 'Card · 00 Who Is Aj Rome', '1080 x 1350', 'https://aaronjayrome.github.io/dts-creative-kit/images/aj-00-who-is-aj-rome.jpg', 1080, 1350),
  (802, 'Poster · Deaddawn Poster B Dawn Alone', '843 x 1280', 'https://aaronjayrome.github.io/dts-creative-kit/images/posters-deaddawn-poster-b-dawn-alone.jpg', 843, 1280),
  (804, 'Poster · Silt Poster A Floating Teal', '843 x 1280', 'https://aaronjayrome.github.io/dts-creative-kit/images/posters-silt-poster-a-floating-teal.jpg', 843, 1280);

delete from dts_kit_assets
 where set_slug in (select slug from dts_kit_asset_sets where active);

insert into dts_kit_assets (set_slug, sort, name, note, url, width, height)
select s.slug, b.sort, b.name, b.note, b.url, b.width, b.height
  from dts_kit_asset_sets s
 cross join _kit_bin b
 where s.active;

commit;


-- ============================================================
-- 5 · VERIFY
-- ============================================================
-- every active set should report 43 assets and 4 captions
select s.slug,
       (select count(*) from dts_kit_assets   k where k.set_slug = s.slug) as assets,
       (select count(*) from dts_kit_captions c where c.set_slug = s.slug) as captions
  from dts_kit_asset_sets s
 where s.active
 order by s.slug;

-- THE CENSUS. This is the number that matters: how many real people sit on each
-- voice. Read it before and after, and make sure the shape matches who they are.
select coalesce(asset_set, '(unstamped)') as asset_set,
       count(*) as people
  from dts_ambassadors
 group by 1
 order by people desc;

-- Anyone still on an unrecoverable historical row
select count(*) as unrecoverable_no_bucket
  from dts_ambassadors where bucket_slug is null;

select 'AJ'   as who, json_array_length(dts_kit('C182D7') -> 'assets') as assets
union all select 'Gene', json_array_length(dts_kit('9163D2') -> 'assets')
union all select 'Jack', json_array_length(dts_kit('21E848') -> 'assets');
