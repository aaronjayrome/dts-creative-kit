-- ============================================================
-- EVERY PERSONAL KIT GETS THE CURRENT BIN  ·  generated, do not hand-edit
-- Built by _source/build_kit_sql.py from the 43 images actually published
-- at https://aaronjayrome.github.io/dts-creative-kit/images/
--
-- Run this in the Supabase SQL editor on dts-prod EVERY TIME THE KIT IS
-- REBUILT. The public page at /creative-kit updates itself; the personal
-- /kit?c=CODE pages read the database, and this is what updates them.
--
-- Fills EVERY ACTIVE SET, not a hardcoded list. That is the point: the last
-- two times this was done by hand, one set got the new work and the other did
-- not, and the people on the stale set had no way to know.
--
-- Captions are deliberately untouched - they differ per set on purpose.
-- Transactional and safe to re-run.
-- ============================================================

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

-- Replace the bin for every active set. Inactive sets are left alone: if
-- somebody retired a set, it is retired.
delete from dts_kit_assets
 where set_slug in (select slug from dts_kit_asset_sets where active);

insert into dts_kit_assets (set_slug, sort, name, note, url, width, height)
select s.slug, b.sort, b.name, b.note, b.url, b.width, b.height
  from dts_kit_asset_sets s
 cross join _kit_bin b
 where s.active;

commit;


-- ---- verify: every active set should report 43 ----
select set_slug, count(*) as assets
  from dts_kit_assets
 group by set_slug
 order by set_slug;

-- ---- the census: how many PEOPLE sit on each set ----
-- This is the number that matters. Everyone who claimed before the OGF bucket
-- existed was backfilled onto 'silt-dead-dawn', so that row is most of the list.
select coalesce(asset_set, '(unstamped)') as asset_set,
       count(*) as people
  from dts_ambassadors
 group by 1
 order by people desc;

-- ---- spot-check three real codes ----
select 'AJ'   as who, json_array_length(dts_kit('C182D7') -> 'assets') as assets
union all select 'Gene', json_array_length(dts_kit('9163D2') -> 'assets')
union all select 'Jack', json_array_length(dts_kit('21E848') -> 'assets');
