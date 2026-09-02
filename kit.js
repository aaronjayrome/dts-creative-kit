/* Demand the Screen - creative kit enhancement layer.
   The page renders completely without this; it adds lane tabs, the
   referral-link prefill, copy buttons and the lightbox. */
(function(){
  function go(){

/* ENHANCEMENT ONLY. Every tile, caption, DM and answer is already in the HTML
   above. If this never runs, the page still shows all of it — stacked with
   headings instead of tabs. Nothing here is load-bearing for content. */
const D = {"captions": {"mission": [["The short one", "You can put a movie in your local theater. That's it, that's the post.\n\nTwo finished independent films are going out with no studio and no distributor \u2014 you put in your ZIP, it finds the actual independent cinema nearest you, and it writes the request for you. Twenty seconds.\n\n{LINK}"], ["The filmmaker one", "Every filmmaker I know has a finished film sitting on a drive.\n\nThe only route most of them are offered is a festival run and a sales agent, and most never get either. So a couple of people are trying the other thing: ask the theaters directly, and let the audience be the reason.\n\nIt's running in public right now, counts and all. Worth watching even if you never sign up.\n\n{LINK}"], ["The local one", "I want to see a real independent film play in {CITY} again.\n\nThere's a thing running right now where you put in your ZIP, it matches you to the actual indie cinema nearest you, and it writes the request to their programmer for you. Takes twenty seconds and it's free.\n\nIf enough of us in {CITY} do it, a real programmer looks at {CITY}. That's the whole mechanism.\n\n{LINK}"], ["The honest one", "This might not work. That's why I like it.\n\nTwo independent features, no studio, no distributor, going straight at theaters and asking audiences to make the case. The numbers are public \u2014 including the cities that aren't working.\n\nI'd rather back something running the experiment in the open.\n\n{LINK}"], ["One line, for a story or a reply", "You can put a movie in your local theater. Twenty seconds and a ZIP code \u2192 {LINK}"]], "films": [["Both films", "Two independent features I want in a theater near me.\n\nDEAD DAWN \u2014 a post office clerk everyone overlooks, and the morning something dark descends. Dark comedy, small-town true crime, a cult anti-hero at the middle of it.\n\nSILT \u2014 a lake house, a fractured group of friends, and whatever is living under the water.\n\nNobody greenlit them. They were made anyway, and now they're being booked the same way \u2014 by asking. Put in your ZIP and it does the rest.\n\n{LINK}"], ["Dead Dawn", "Anna-Beth is the post office clerk everyone overlooks. She can't say no to a bad customer, a worse boss, or the ex who won't let go \u2014 until something dark descends with the dawn and the woman nobody saw coming finds out exactly what she's capable of.\n\nDEAD DAWN. Ashley Lenz, Olivia Grace Applegate, Malcolm Goodwin, David Anders, Krishna Smitha, Michael Papajohn, Isaiah LaBorde. Produced by Isaiah LaBorde. Written and directed by Aaron Jay Rome.\n\nIt's going to theaters without a studio. Your ZIP is the whole ask \u2192 {LINK}"], ["Silt", "A lake house. A fractured group of friends. A weekend that was supposed to fix everything. Old wounds have a way of surfacing \u2014 and whatever is living under that water knows exactly where to find them.\n\nSILT. Andrea Sixtos, David Anders, Malcolm Goodwin, Tommy Wiseau, Olivia Grace Applegate, Michael Papajohn, Vernon Davis, Krishna Smitha, Isaiah LaBorde.\n\nStory by Vernon Davis & Tiffany Toney. Produced by Isaiah LaBorde. Executive producer Vernon Davis. Written and directed by Aaron Jay Rome.\n\n{LINK}"], ["The cast hook", "Six actors appear in BOTH films: Malcolm Goodwin, Krishna Smitha, Olivia Grace Applegate, David Anders, Michael Papajohn and Isaiah LaBorde \u2014 who also produced both.\n\nTommy Wiseau and Vernon Davis are in SILT, which Davis also executive produced.\n\nNo studio, no distributor \u2014 they're being booked by audience request, one city at a time. Put in your ZIP and it writes the request for you.\n\n{LINK}"], ["One line, for a story or a reply", "Two indie features, no studio, going to theaters by request. Twenty seconds \u2192 {LINK}"]]}, "dms": [["Someone who'd genuinely see it", "Hey \u2014 do you still go to the movies downtown? There's an indie feature trying to get booked in {CITY} and it takes twenty seconds to put your ZIP in and add your name to the ask. No money, no sign-up hell. {LINK} \u2014 would mean a lot if you did it."], ["A filmmaker friend", "You'll find this interesting regardless of whether you sign up. Two finished features are being released by asking theaters directly instead of going the festival/sales-agent route, and the whole thing is running in public with the counts visible. {LINK}"], ["Somebody local with a following", "Long shot \u2014 I'm helping get an independent film in front of a programmer in {CITY}. It works on volume of local requests, so one post from you would do more than a hundred from me. Happy to send you the images and caption ready to go. {LINK}"], ["Family / not-a-film-person", "Doing a thing to get a movie into a theater here in {CITY}. It's genuinely twenty seconds \u2014 you put in your zip code and it writes an email to the local cinema for you. {LINK}"], ["The follow-up, 3\u20134 days later", "Hey, did the theater ever write back to you? If they did, could you forward it to team@demandthescreen.com? The reply goes to your inbox rather than ours, so that's the only way we see it \u2014 and a programmer replying is the most useful thing that happens all week."]]};
document.body.classList.add("js-on");

const $ = s => document.querySelector(s);
const $$ = s => [...document.querySelectorAll(s)];
const store = {
  get(k, d){ try { return localStorage.getItem(k) ?? d; } catch(e){ return d; } },
  set(k, v){ try { localStorage.setItem(k, v); } catch(e){} }
};
const linkEl = $("#f-link"), cityEl = $("#f-city"), okEl = $("#setup-ok");
const SHARE = "https://demandthescreen.com/demand-page?ref=";

/* Nobody should have to know what a "referral link" is or where it lives.
   Priority: the ?ref= the email put in the URL, then whatever is remembered on
   this device. Either a bare 6-character code or a whole link is accepted. */
function codeFrom(v){
  const m = String(v || "").toUpperCase().match(/\b([0-9A-F]{6})\b/);
  return m ? m[1] : null;
}
function resolveLink(){
  const raw = (linkEl && linkEl.value.trim()) || "";
  const code = codeFrom(raw);
  if (code) return SHARE + code;
  return /^https?:\/\//i.test(raw) ? raw : "";
}
function markResolved(){
  if (!okEl) return;
  const url = resolveLink();
  if (url){
    okEl.hidden = false;
    okEl.innerHTML = "Using <b>" + esc(url) + "</b> in every caption below.";
  } else {
    okEl.hidden = true;
  }
}

const qs = new URLSearchParams(location.search);
const fromUrl = qs.get("ref") || qs.get("c") || qs.get("code") || "";
if (linkEl){
  const remembered = store.get("dts_link", "");
  linkEl.value = fromUrl ? (codeFrom(fromUrl) || fromUrl) : remembered;
  if (fromUrl) store.set("dts_link", linkEl.value);
}
if (cityEl) cityEl.value = store.get("dts_city", "");
const cityFromUrl = qs.get("city");
if (cityFromUrl && cityEl){ cityEl.value = cityFromUrl; store.set("dts_city", cityFromUrl); }

function esc(s){ return String(s).replace(/[&<>"]/g,
  c => ({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;"}[c])); }

/* Rewrite the pre-rendered caption bodies with the reader's own link and city.
   Anything still unfilled stays highlighted, so a placeholder cannot quietly
   reach a real post. */
function fill(t){
  const link = resolveLink() || "{your link}";
  const city = (cityEl && cityEl.value.trim()) || "{your city}";
  return esc(t.replace(/\{LINK\}/g, link).replace(/\{CITY\}/g, city))
           .replace(/\{your (link|city)\}/g, m => "<mark>" + m + "</mark>");
}
function paint(){
  for (const lane of ["mission", "films"])
    (D.captions[lane] || []).forEach(function(pair, i){
      const el = document.querySelector('[data-body="cap-' + lane + '-' + i + '"]');
      if (el) el.innerHTML = fill(pair[1]);
    });
  (D.dms || []).forEach(function(pair, i){
    const el = document.querySelector('[data-body="dm-' + i + '"]');
    if (el) el.innerHTML = fill(pair[1]);
  });
}

function showLane(lane){
  $$("[data-lane-block]").forEach(b => b.hidden = b.dataset.laneBlock !== lane);
  $$("[data-lane]").forEach(b => b.setAttribute("aria-selected", b.dataset.lane === lane));
}
function showBin(bin){
  $$("[data-bin-block]").forEach(b => b.hidden = b.dataset.binBlock !== bin);
  $$("[data-bin]").forEach(b => b.setAttribute("aria-selected", b.dataset.bin === bin));
}

document.addEventListener("click", function(e){
  const c = e.target.closest(".copy");
  if (c){
    const body = document.querySelector('[data-body="' + c.dataset.k + '"]');
    if (!body) return;
    navigator.clipboard.writeText(body.innerText).then(function(){
      c.textContent = "Copied"; c.classList.add("done");
      setTimeout(function(){ c.textContent = "Copy"; c.classList.remove("done"); }, 1600);
    }).catch(function(){ c.textContent = "Select & copy"; });
    return;
  }
  const t = e.target.closest(".tile");
  if (t){
    /* Read the source off the tile's own <img> rather than a parallel data
       structure. Carrying the images a second time in JSON doubled the
       self-contained build to 13MB, against a 16MB ceiling. */
    const img = t.querySelector("img");
    if (!img) return;
    $("#lb-img").src = img.currentSrc || img.src;
    $("#lb-img").alt = img.alt;
    $("#lb-cap").textContent = img.alt;
    $("#lb").classList.add("on");
    return;
  }
  const l = e.target.closest("[data-lane]"); if (l){ showLane(l.dataset.lane); return; }
  const b = e.target.closest("[data-bin]");  if (b){ showBin(b.dataset.bin); return; }
  if (e.target.id === "lb-x" || e.target.id === "lb") $("#lb").classList.remove("on");
});
document.addEventListener("keydown", function(e){
  if (e.key === "Escape") $("#lb").classList.remove("on");
});
[linkEl, cityEl].forEach(el => el && el.addEventListener("input", function(){
  store.set("dts_link", linkEl.value); store.set("dts_city", cityEl.value);
  paint(); markResolved();
}));

showLane("mission");
showBin("stills");
paint();
markResolved();
  }
  if (document.readyState === "loading")
    document.addEventListener("DOMContentLoaded", go);
  else go();
})();
