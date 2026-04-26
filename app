<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0">
<title>SetFlow · Press Play.</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&family=Roboto:wght@300;400;500;700&family=Roboto+Mono:wght@400;500&display=swap" rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>

<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;-webkit-tap-highlight-color:transparent}
:root{
  /* Surface palette */
  --bg:#FAFBFC;
  --surface:#FFFFFF;
  --surface-2:#F1F3F4;
  --surface-3:#E8EAED;
  --border:#DADCE0;
  --border-soft:#EBEDEF;
  --border-hover:#BDC1C6;
  /* Text */
  --ink:#202124;
  --ink-2:#3C4043;
  --muted:#5F6368;
  --dim:#80868B;
  --whisper:#BDC1C6;
  /* Google brand */
  --g-blue:#1A73E8; --g-blue-h:#1557B0; --g-blue-bg:#E8F0FE; --g-blue-soft:#D2E3FC; --g-blue-bd:#AECBFA;
  --g-red:#EA4335; --g-red-bg:#FCE8E6; --g-red-bd:#F8C0BB;
  --g-yel:#F9AB00; --g-yel-bg:#FEF7E0; --g-yel-bd:#FDE293; --g-yel-ink:#A8530A;
  --g-grn:#34A853; --g-grn-bg:#E6F4EA; --g-grn-bd:#A8D5B5;
  /* PREMIUM GOLD — subtle, used on premium edges */
  --gold:#C9A961;
  --gold-h:#B89548;
  --gold-light:#E8DBB7;
  --gold-bg:rgba(201,169,97,0.08);
  --gold-glow:rgba(201,169,97,0.18);
  /* Effects */
  --shadow-sm:0 1px 2px rgba(60,64,67,0.08);
  --shadow:0 1px 3px rgba(60,64,67,0.10),0 4px 8px rgba(60,64,67,0.05);
  --shadow-md:0 2px 6px rgba(60,64,67,0.12),0 8px 24px rgba(60,64,67,0.08);
  --shadow-lg:0 4px 14px rgba(60,64,67,0.15),0 16px 48px rgba(60,64,67,0.10);
  --shadow-gold:0 0 0 1px var(--gold),0 8px 24px rgba(201,169,97,0.18);
  --r-sm:6px; --r:8px; --r-md:12px; --r-lg:16px; --r-xl:20px;
  --t-fast:120ms cubic-bezier(0.4,0,0.2,1);
  --t:180ms cubic-bezier(0.4,0,0.2,1);
  --t-slow:280ms cubic-bezier(0.4,0,0.2,1);
}
html,body{font-family:'Roboto','Google Sans',system-ui,-apple-system,sans-serif;background:var(--bg);color:var(--ink);min-height:100vh;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;font-size:14px;line-height:1.5}
body{display:flex;overflow-x:hidden}
::-webkit-scrollbar{width:8px;height:8px}
::-webkit-scrollbar-track{background:transparent}
::-webkit-scrollbar-thumb{background:var(--surface-3);border-radius:4px;border:2px solid var(--bg)}
::-webkit-scrollbar-thumb:hover{background:var(--border-hover)}

/* Premium gold accent bar at the very top */
.gold-bar{position:fixed;top:0;left:0;right:0;height:3px;background:linear-gradient(90deg,#007A4D 0%,#007A4D 33%,#FFB612 33%,#FFB612 50%,#DE3831 50%,#DE3831 67%,#002395 67%,#002395 100%);z-index:200;pointer-events:none;opacity:0.85}

/* ─────────────────────────────────────────────────── SIDEBAR */
.sidebar{width:248px;height:100vh;position:sticky;top:0;background:var(--surface);border-right:1px solid var(--border);display:flex;flex-direction:column;flex-shrink:0;z-index:50;overflow-y:auto;transition:transform var(--t-slow)}
.brand{padding:20px 22px 16px;display:flex;align-items:center;gap:10px;border-bottom:1px solid var(--border-soft)}
.brand-mark{width:32px;height:32px;border-radius:8px;background:linear-gradient(135deg,#007A4D 0%,#FFB612 40%,#DE3831 70%,#002395 100%);display:flex;align-items:center;justify-content:center;font-family:'Google Sans';font-weight:700;font-size:16px;color:#fff;flex-shrink:0;position:relative;overflow:hidden;box-shadow:0 2px 8px rgba(0,122,77,0.35)}
.brand-mark::after{content:'';position:absolute;inset:0;border:1px solid rgba(255,255,255,0.18);border-radius:8px}
.brand-name{font-family:'Google Sans';font-size:18px;font-weight:500;letter-spacing:-0.2px}
.brand-name .l1{color:#007A4D}.brand-name .l2{color:#DE3831}.brand-name .l3{color:#FFB612}.brand-name .l4{color:#002395}.brand-name .l5{color:#007A4D}.brand-name .l6{color:#DE3831}.brand-name .l7{color:#FFB612}
.brand-tag{font-size:9px;font-family:'Roboto Mono';color:var(--gold-h);letter-spacing:0.16em;text-transform:uppercase;font-weight:500;margin-top:1px}

.workspace-block{padding:14px 16px;border-bottom:1px solid var(--border-soft)}
.workspace-label{font-size:10px;font-family:'Roboto Mono';color:var(--dim);text-transform:uppercase;letter-spacing:0.12em;margin-bottom:8px;font-weight:500}
.artist-pill{display:flex;align-items:center;gap:10px;padding:8px 10px;border-radius:var(--r);border:1px solid var(--border);cursor:pointer;transition:all var(--t);background:var(--surface);position:relative}
.artist-pill::after{content:'▾';position:absolute;right:10px;top:50%;transform:translateY(-50%);font-size:9px;color:var(--dim);transition:transform var(--t)}
.artist-pill.open::after{transform:translateY(-50%) rotate(180deg)}
.artist-pill:hover{border-color:var(--gold);background:var(--gold-bg);box-shadow:var(--shadow-sm)}
.avatar{width:30px;height:30px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-weight:500;font-size:11px;color:#fff;flex-shrink:0;position:relative}
.avatar::after{content:'';position:absolute;inset:0;border-radius:50%;border:1px solid rgba(0,0,0,0.06)}
.avatar.bc{background:linear-gradient(135deg,#1A73E8,#4285F4)}
.avatar.sh{background:linear-gradient(135deg,#EA4335,#FB6156)}
.avatar.th{background:linear-gradient(135deg,#34A853,#5BB974)}
.avatar.dg{background:linear-gradient(135deg,#F9AB00,#FCC934)}
.artist-info{flex:1;min-width:0}
.artist-name{font-size:13px;font-weight:500;line-height:1.2;color:var(--ink);white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.artist-genre{font-size:10px;color:var(--muted);line-height:1.3;margin-top:1px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.artist-menu{margin-top:6px;display:none;flex-direction:column;gap:1px;background:var(--surface-2);border-radius:var(--r);padding:4px;border:1px solid var(--border-soft)}
.artist-menu.open{display:flex;animation:slideDown var(--t) ease}
.artist-menu-item{display:flex;align-items:center;gap:8px;padding:6px 8px;border-radius:6px;cursor:pointer;font-size:12px;color:var(--ink-2);transition:background var(--t)}
.artist-menu-item:hover{background:var(--surface)}
.artist-menu-item.active{background:var(--g-blue-bg);color:var(--g-blue);font-weight:500}
@keyframes slideDown{from{opacity:0;transform:translateY(-4px)}to{opacity:1;transform:translateY(0)}}

.nav-area{flex:1;padding:8px;overflow-y:auto}
.nav-group{font-size:10px;font-family:'Roboto Mono';color:var(--dim);text-transform:uppercase;letter-spacing:0.12em;padding:14px 12px 6px;font-weight:500}
.nav-group:first-child{padding-top:8px}
.nav-item{display:flex;align-items:center;gap:12px;padding:8px 12px;margin:1px 0;border-radius:100px;font-size:13px;font-weight:400;color:var(--ink-2);cursor:pointer;transition:all var(--t);user-select:none;position:relative}
.nav-item:hover{background:var(--surface-2);color:var(--ink)}
.nav-item.active{background:var(--g-blue-bg);color:var(--g-blue);font-weight:500}
.nav-item.active::before{content:'';position:absolute;left:0;top:50%;transform:translateY(-50%);width:3px;height:18px;background:var(--g-blue);border-radius:0 3px 3px 0}
.nav-icon{width:18px;height:18px;display:flex;align-items:center;justify-content:center;flex-shrink:0}
.nav-icon svg{width:18px;height:18px;stroke-width:1.8}
.nav-badge{margin-left:auto;font-size:10px;font-family:'Roboto Mono';padding:2px 7px;border-radius:100px;font-weight:500}
.nav-badge.blue{background:var(--g-blue-bg);color:var(--g-blue)}
.nav-badge.red{background:var(--g-red-bg);color:var(--g-red)}
.nav-badge.gold{background:var(--gold-bg);color:var(--gold-h);border:1px solid var(--gold)}

.sidebar-foot{padding:14px 16px;border-top:1px solid var(--border-soft);background:var(--surface)}
.plan-pill{display:inline-flex;align-items:center;gap:5px;font-size:10px;font-family:'Roboto Mono';color:var(--gold-h);background:var(--gold-bg);border:1px solid var(--gold);padding:3px 8px;border-radius:100px;letter-spacing:0.06em;font-weight:500;margin-bottom:6px}
.plan-pill::before{content:'';width:5px;height:5px;background:var(--gold);border-radius:50%}
.user-row{display:flex;align-items:center;gap:8px}
.user-row .avatar{width:24px;height:24px;font-size:9px}
.user-info{flex:1;min-width:0}
.user-name{font-size:12px;font-weight:500;line-height:1.2;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.user-role{font-size:10px;color:var(--muted);line-height:1.2;margin-top:1px}

/* ─────────────────────────────────────────────────── MAIN */
.main{flex:1;min-width:0;display:flex;flex-direction:column;height:100vh;overflow-y:auto}
.topbar{position:sticky;top:0;z-index:30;display:flex;align-items:center;gap:12px;padding:12px 28px;background:rgba(255,255,255,0.92);backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border-bottom:1px solid var(--border-soft)}
.menu-btn{display:none;width:36px;height:36px;border-radius:50%;background:transparent;border:none;cursor:pointer;align-items:center;justify-content:center;transition:background var(--t)}
.menu-btn:hover{background:var(--surface-2)}
.search{flex:1;max-width:560px;position:relative}
.search input{width:100%;height:40px;padding:0 16px 0 42px;border:1px solid var(--border);background:var(--surface-2);border-radius:100px;font-size:13px;color:var(--ink);outline:none;transition:all var(--t);font-family:inherit}
.search input::placeholder{color:var(--muted)}
.search input:focus{background:var(--surface);border-color:var(--gold);box-shadow:0 0 0 4px var(--gold-glow)}
.search-icon{position:absolute;left:14px;top:50%;transform:translateY(-50%);color:var(--muted);pointer-events:none;display:flex}
.kbd{position:absolute;right:12px;top:50%;transform:translateY(-50%);font-family:'Roboto Mono';font-size:10px;background:var(--surface);border:1px solid var(--border);padding:2px 6px;border-radius:4px;color:var(--muted)}
.icon-btn{width:40px;height:40px;border-radius:50%;background:transparent;border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;color:var(--ink-2);transition:all var(--t);position:relative;flex-shrink:0}
.icon-btn:hover{background:var(--surface-2)}
.icon-btn .dot{position:absolute;top:9px;right:9px;width:7px;height:7px;background:var(--g-red);border-radius:50%;border:2px solid var(--surface);animation:pulse 2s ease-in-out infinite}
@keyframes pulse{0%,100%{box-shadow:0 0 0 0 rgba(234,67,53,0.5)}50%{box-shadow:0 0 0 6px rgba(234,67,53,0)}}

/* Page header */
.page{padding:24px 28px 48px;animation:fadeIn 320ms ease}
@keyframes fadeIn{from{opacity:0;transform:translateY(8px)}to{opacity:1;transform:translateY(0)}}
.page-head{display:flex;align-items:flex-end;justify-content:space-between;gap:16px;margin-bottom:24px;flex-wrap:wrap}
.page-title{font-family:'Google Sans';font-size:28px;font-weight:500;letter-spacing:-0.5px;line-height:1.2}
.page-sub{font-size:13px;color:var(--muted);margin-top:4px}
.page-sub b{color:var(--ink-2);font-weight:500}
.page-actions{display:flex;align-items:center;gap:8px;flex-shrink:0}

/* Buttons */
.btn{display:inline-flex;align-items:center;gap:6px;font-family:inherit;font-size:13px;font-weight:500;height:36px;padding:0 16px;border-radius:100px;border:1px solid var(--border);background:var(--surface);color:var(--ink-2);cursor:pointer;transition:all var(--t);white-space:nowrap;user-select:none}
.btn:hover{background:var(--surface-2);border-color:var(--border-hover);box-shadow:var(--shadow-sm)}
.btn:active{transform:scale(0.97)}
.btn.primary{background:var(--g-blue);border-color:var(--g-blue);color:#fff}
.btn.primary:hover{background:var(--g-blue-h);border-color:var(--g-blue-h);box-shadow:0 2px 8px rgba(26,115,232,0.30)}
.btn.gold{background:linear-gradient(135deg,#D4B97E 0%,#C9A961 50%,#B89548 100%);border-color:var(--gold-h);color:#fff;box-shadow:0 1px 3px rgba(184,149,72,0.35)}
.btn.gold:hover{box-shadow:0 4px 14px rgba(184,149,72,0.40)}
.btn.ghost{background:transparent;border-color:transparent}
.btn.ghost:hover{background:var(--surface-2)}
.btn.sm{height:30px;padding:0 12px;font-size:12px}
.btn.icon-only{width:36px;padding:0;justify-content:center}

/* ─────────────────────────────────────────────────── HERO + STATS */
.hero{display:grid;grid-template-columns:1.4fr 1fr;gap:16px;margin-bottom:24px}
@media (max-width:980px){.hero{grid-template-columns:1fr}}
.hero-card{background:var(--surface);border:1px solid var(--border);border-radius:var(--r-lg);padding:24px;position:relative;overflow:hidden;transition:all var(--t)}
.hero-card.feature{background:linear-gradient(135deg,#022B18 0%,#004D2E 35%,#003366 70%,#001A4D 100%);color:#fff;border:none;position:relative}
.hero-card.feature::before{content:'';position:absolute;top:0;right:0;width:200px;height:200px;background:radial-gradient(circle,var(--gold-glow) 0%,transparent 70%);pointer-events:none}
.hero-card.feature::after{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent,var(--gold-light) 50%,transparent)}
.hero-greeting{font-family:'Google Sans';font-size:14px;font-weight:500;opacity:0.85;margin-bottom:4px;letter-spacing:0.4px}
.hero-name{font-family:'Google Sans';font-size:32px;font-weight:500;letter-spacing:-0.5px;line-height:1.1;margin-bottom:14px}
.hero-stats-row{display:flex;gap:24px;margin-bottom:18px;padding:12px 16px;background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.10);border-radius:var(--r-md);backdrop-filter:blur(8px)}
.hero-stat-item{flex:1}
.hero-stat-label{font-size:10px;text-transform:uppercase;letter-spacing:0.12em;opacity:0.7;font-family:'Roboto Mono';margin-bottom:4px}
.hero-stat-val{font-family:'Google Sans';font-size:22px;font-weight:500;line-height:1}
.hero-stat-val .delta{font-size:11px;color:#5BB974;margin-left:6px;font-family:'Roboto Mono';font-weight:400}
.hero-cta-row{display:flex;gap:8px;flex-wrap:wrap}
.hero-pill{display:inline-flex;align-items:center;gap:8px;padding:8px 14px;background:rgba(255,255,255,0.10);border:1px solid rgba(255,255,255,0.16);border-radius:100px;font-size:12px;font-weight:500;cursor:pointer;transition:all var(--t)}
.hero-pill:hover{background:rgba(255,255,255,0.18);border-color:var(--gold-light)}
.hero-pill .ball{width:6px;height:6px;border-radius:50%;background:var(--gold)}
.hero-pill.urgent .ball{background:#FF6B6B;animation:pulse 1.6s ease-in-out infinite}

/* Sparkline mini cards on right side of hero */
.spark-grid{display:grid;grid-template-columns:1fr 1fr;gap:12px;height:100%}
.spark-card{background:var(--surface);border:1px solid var(--border);border-radius:var(--r-md);padding:14px;display:flex;flex-direction:column;justify-content:space-between;transition:all var(--t);cursor:pointer;position:relative;overflow:hidden;min-height:96px}
.spark-card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;border-radius:var(--r-md) var(--r-md) 0 0}
.spark-card.blue::before{background:var(--g-blue)}
.spark-card.red::before{background:var(--g-red)}
.spark-card.yel::before{background:var(--g-yel)}
.spark-card.grn::before{background:var(--g-grn)}
.spark-card:hover{transform:translateY(-2px);box-shadow:var(--shadow-md);border-color:var(--gold)}
.spark-label{font-size:10px;text-transform:uppercase;letter-spacing:0.1em;color:var(--muted);font-family:'Roboto Mono';font-weight:500}
.spark-row{display:flex;align-items:flex-end;justify-content:space-between;gap:8px}
.spark-num{font-family:'Google Sans';font-size:22px;font-weight:500;color:var(--ink);line-height:1}
.spark-svg{width:60px;height:24px;flex-shrink:0}
.spark-foot{font-size:11px;font-family:'Roboto Mono';color:var(--muted)}
.spark-foot .up{color:var(--g-grn);font-weight:500}
.spark-foot .down{color:var(--g-red);font-weight:500}

/* ─────────────────────────────────────────────────── SECTION HEAD */
.sec-head{display:flex;align-items:center;justify-content:space-between;margin-bottom:14px;gap:12px;flex-wrap:wrap}
.sec-title{font-family:'Google Sans';font-size:16px;font-weight:500;letter-spacing:-0.2px}
.sec-meta{font-size:12px;color:var(--muted);font-family:'Roboto Mono'}
.sec-tabs{display:flex;gap:4px;background:var(--surface-2);padding:3px;border-radius:100px;border:1px solid var(--border-soft)}
.sec-tab{font-family:inherit;font-size:12px;font-weight:500;height:28px;padding:0 14px;border-radius:100px;border:none;background:transparent;color:var(--muted);cursor:pointer;transition:all var(--t)}
.sec-tab.active{background:var(--surface);color:var(--g-blue);box-shadow:var(--shadow-sm)}

/* ─────────────────────────────────────────────────── REVENUE CHART */
.chart-card{background:var(--surface);border:1px solid var(--border);border-radius:var(--r-lg);padding:24px;margin-bottom:24px;position:relative}
.chart-card::after{content:'';position:absolute;top:0;left:24px;right:24px;height:1px;background:linear-gradient(90deg,transparent,var(--gold) 50%,transparent);opacity:0.4}
.chart-head{display:flex;align-items:flex-start;justify-content:space-between;margin-bottom:8px;flex-wrap:wrap;gap:12px}
.chart-title{font-family:'Google Sans';font-size:14px;font-weight:500;color:var(--ink-2);margin-bottom:2px}
.chart-big{font-family:'Google Sans';font-size:32px;font-weight:500;letter-spacing:-0.6px;color:var(--ink);line-height:1}
.chart-delta{display:inline-flex;align-items:center;gap:4px;font-size:12px;font-family:'Roboto Mono';font-weight:500;color:var(--g-grn);background:var(--g-grn-bg);padding:3px 8px;border-radius:100px;margin-left:10px;vertical-align:middle}
.chart-svg-wrap{margin-top:18px;width:100%;overflow:hidden}
.chart-legend{display:flex;gap:18px;margin-top:14px;flex-wrap:wrap}
.legend-item{display:flex;align-items:center;gap:6px;font-size:11px;color:var(--muted);font-family:'Roboto Mono'}
.legend-dot{width:8px;height:8px;border-radius:50%}

/* ─────────────────────────────────────────────────── PIPELINE KANBAN */
.pipeline{display:grid;grid-template-columns:repeat(4,1fr);gap:14px;margin-bottom:24px}
@media (max-width:1100px){.pipeline{grid-template-columns:repeat(2,1fr)}}
@media (max-width:560px){.pipeline{grid-template-columns:1fr}}
.kanban-col{background:var(--surface);border:1px solid var(--border);border-radius:var(--r-lg);padding:14px;min-height:300px;display:flex;flex-direction:column}
.kanban-head{display:flex;align-items:center;gap:8px;padding:0 4px 12px;border-bottom:1px dashed var(--border-soft);margin-bottom:10px}
.kanban-dot{width:8px;height:8px;border-radius:50%;flex-shrink:0}
.kanban-name{font-family:'Google Sans';font-size:13px;font-weight:500}
.kanban-count{margin-left:auto;font-size:11px;font-family:'Roboto Mono';font-weight:500;background:var(--surface-2);padding:2px 8px;border-radius:100px;color:var(--muted)}
.kanban-sum{font-size:11px;font-family:'Roboto Mono';color:var(--muted);padding:0 4px 8px}
.kanban-list{display:flex;flex-direction:column;gap:8px;flex:1;overflow-y:auto;max-height:340px;padding-right:2px}
.gig-card{background:var(--surface);border:1px solid var(--border);border-radius:var(--r-md);padding:12px;cursor:pointer;transition:all var(--t);position:relative}
.gig-card:hover{transform:translateY(-2px);box-shadow:var(--shadow-md);border-color:var(--gold)}
.gig-card.urgent{border-left:3px solid var(--g-red)}
.gig-row{display:flex;justify-content:space-between;align-items:flex-start;gap:8px;margin-bottom:6px}
.gig-flag{font-size:14px;line-height:1}
.gig-name{font-size:13px;font-weight:500;line-height:1.3;color:var(--ink)}
.gig-city{font-size:11px;color:var(--muted);font-family:'Roboto Mono';margin-top:2px}
.gig-tag{font-size:9px;font-family:'Roboto Mono';padding:2px 6px;border-radius:4px;font-weight:500;text-transform:uppercase;letter-spacing:0.08em;flex-shrink:0}
.gig-tag.club{background:var(--g-blue-bg);color:var(--g-blue)}
.gig-tag.fest{background:var(--gold-bg);color:var(--gold-h)}
.gig-tag.event{background:var(--g-grn-bg);color:var(--g-grn)}
.gig-foot{display:flex;justify-content:space-between;align-items:center;margin-top:8px;padding-top:8px;border-top:1px dashed var(--border-soft)}
.gig-date{font-size:11px;color:var(--dim);font-family:'Roboto Mono'}
.gig-fee{font-size:13px;font-weight:500;font-family:'Roboto Mono'}
.gig-fee.pos{color:var(--g-grn)}
.gig-fee.neg{color:var(--g-yel-ink)}
.kanban-empty{text-align:center;font-size:12px;color:var(--dim);padding:20px;font-style:italic}

/* ─────────────────────────────────────────────────── TABLE */
.table-card{background:var(--surface);border:1px solid var(--border);border-radius:var(--r-lg);overflow:hidden;margin-bottom:24px}
.tbl{width:100%;border-collapse:collapse}
.tbl thead th{font-size:10px;font-family:'Roboto Mono';text-transform:uppercase;letter-spacing:0.1em;color:var(--muted);font-weight:500;text-align:left;padding:12px 18px;border-bottom:1px solid var(--border-soft);background:var(--surface-2);white-space:nowrap}
.tbl tbody td{padding:14px 18px;border-bottom:1px solid var(--border-soft);font-size:13px;vertical-align:middle}
.tbl tbody tr{cursor:pointer;transition:background var(--t-fast)}
.tbl tbody tr:hover{background:var(--surface-2)}
.tbl tbody tr:hover td:first-child{box-shadow:inset 3px 0 0 var(--gold)}
.tbl tbody tr:last-child td{border-bottom:none}
.tbl .mono{font-family:'Roboto Mono'}
.tbl .strong{font-weight:500;color:var(--ink)}

/* Badges */
.badge{display:inline-flex;align-items:center;gap:5px;font-size:11px;font-family:'Roboto Mono';font-weight:500;padding:3px 9px;border-radius:100px;white-space:nowrap;border:1px solid transparent}
.badge::before{content:'';width:5px;height:5px;border-radius:50%;background:currentColor}
.b-confirmed{background:var(--g-grn-bg);color:var(--g-grn)}
.b-hold{background:var(--g-yel-bg);color:var(--g-yel-ink);border-color:var(--g-yel-bd)}
.b-inquiry{background:var(--g-blue-bg);color:var(--g-blue)}
.b-cancelled{background:var(--g-red-bg);color:var(--g-red)}
.b-signed{background:var(--g-grn-bg);color:var(--g-grn)}
.b-pending{background:var(--g-yel-bg);color:var(--g-yel-ink);border-color:var(--g-yel-bd)}
.b-none{background:var(--surface-2);color:var(--muted)}
.dep-yes{color:var(--g-grn);font-family:'Roboto Mono';font-size:12px;font-weight:500}
.dep-no{color:var(--dim);font-family:'Roboto Mono';font-size:12px}

/* ─────────────────────────────────────────────────── ACTIVITY FEED + UPCOMING */
.split{display:grid;grid-template-columns:1.4fr 1fr;gap:16px;margin-bottom:24px}
@media (max-width:980px){.split{grid-template-columns:1fr}}
.feed-card{background:var(--surface);border:1px solid var(--border);border-radius:var(--r-lg);padding:0;overflow:hidden;display:flex;flex-direction:column;max-height:420px}
.feed-head{padding:18px 20px 12px;border-bottom:1px solid var(--border-soft);display:flex;align-items:center;justify-content:space-between}
.feed-head .sec-title{font-size:14px}
.feed-list{flex:1;overflow-y:auto;padding:8px 0}
.feed-item{display:flex;gap:12px;padding:10px 20px;cursor:pointer;transition:background var(--t-fast);border-left:3px solid transparent}
.feed-item:hover{background:var(--surface-2);border-left-color:var(--gold)}
.feed-icon{width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;font-size:14px}
.feed-icon.blue{background:var(--g-blue-bg);color:var(--g-blue)}
.feed-icon.green{background:var(--g-grn-bg);color:var(--g-grn)}
.feed-icon.gold{background:var(--gold-bg);color:var(--gold-h)}
.feed-icon.red{background:var(--g-red-bg);color:var(--g-red)}
.feed-body{flex:1;min-width:0}
.feed-text{font-size:13px;line-height:1.45;color:var(--ink-2)}
.feed-text b{font-weight:500;color:var(--ink)}
.feed-time{font-size:10px;color:var(--dim);font-family:'Roboto Mono';margin-top:2px;letter-spacing:0.04em}

/* ─────────────────────────────────────────────────── CALENDAR */
.cal-card{background:var(--surface);border:1px solid var(--border);border-radius:var(--r-lg);padding:24px}
.cal-toolbar{display:flex;align-items:center;justify-content:space-between;margin-bottom:18px;flex-wrap:wrap;gap:12px}
.cal-month{font-family:'Google Sans';font-size:22px;font-weight:500;letter-spacing:-0.3px}
.cal-month .yr{color:var(--muted);font-weight:400;margin-left:6px}
.cal-nav-grp{display:flex;gap:4px}
.cal-grid{display:grid;grid-template-columns:repeat(7,1fr);gap:4px}
.cal-dow{font-size:10px;font-family:'Roboto Mono';color:var(--muted);text-transform:uppercase;letter-spacing:0.1em;text-align:center;padding:8px 0;font-weight:500}
.cal-day{aspect-ratio:1;display:flex;flex-direction:column;align-items:center;justify-content:flex-start;padding:6px 0 0;border-radius:var(--r);cursor:pointer;font-size:13px;color:var(--ink-2);font-weight:400;transition:all var(--t-fast);position:relative;border:1px solid transparent;min-height:48px}
.cal-day:hover{background:var(--surface-2);border-color:var(--border)}
.cal-day.empty{pointer-events:none;opacity:0}
.cal-day.today{background:var(--g-blue);color:#fff;font-weight:500}
.cal-day.today:hover{background:var(--g-blue-h);border-color:var(--g-blue-h)}
.cal-day.has{font-weight:500;color:var(--ink)}
.cal-pellets{display:flex;gap:2px;margin-top:auto;margin-bottom:6px;justify-content:center;height:4px}
.cal-pellet{width:4px;height:4px;border-radius:50%}
.cal-pellet.confirmed{background:var(--g-grn)}
.cal-pellet.hold{background:var(--g-yel)}
.cal-pellet.inquiry{background:var(--g-blue)}
.cal-detail{margin-top:18px;padding:16px;background:var(--surface-2);border-radius:var(--r-md);border:1px solid var(--border-soft);min-height:60px;font-size:13px;color:var(--muted)}
.cal-detail.empty{font-style:italic;text-align:center;padding:24px}

/* ─────────────────────────────────────────────────── TOUR MAP */
.map-card{background:var(--surface);border:1px solid var(--border);border-radius:var(--r-lg);padding:16px;margin-bottom:24px}
.map-stats{display:grid;grid-template-columns:repeat(auto-fit,minmax(140px,1fr));gap:12px;margin-top:18px}
.map-stat{padding:14px;background:var(--surface-2);border-radius:var(--r-md);border:1px solid var(--border-soft);transition:all var(--t)}
.map-stat:hover{border-color:var(--gold);background:var(--surface)}
.map-stat-flag{font-size:18px;margin-bottom:4px;display:block}
.map-stat-name{font-size:12px;font-weight:500;color:var(--ink-2)}
.map-stat-data{font-size:11px;font-family:'Roboto Mono';color:var(--muted);margin-top:2px}
/* Leaflet popup override */
@keyframes spin{to{transform:rotate(360deg)}}

/* ─────────────────────────────────────────────────── REVENUE VIEW */
.rev-grid{display:grid;grid-template-columns:2fr 1fr;gap:16px;margin-bottom:24px}
@media (max-width:980px){.rev-grid{grid-template-columns:1fr}}
.bar-row{display:flex;align-items:center;gap:12px;padding:10px 0}
.bar-label{font-size:13px;color:var(--ink-2);width:100px;flex-shrink:0;font-weight:500}
.bar-track{flex:1;height:8px;background:var(--surface-2);border-radius:100px;overflow:hidden;position:relative}
.bar-fill{height:100%;border-radius:100px;transition:width 800ms cubic-bezier(0.4,0,0.2,1)}
.bar-val{font-size:12px;font-family:'Roboto Mono';font-weight:500;width:74px;text-align:right;color:var(--ink-2)}
.pay-row{display:flex;justify-content:space-between;align-items:center;padding:14px 0;border-bottom:1px solid var(--border-soft)}
.pay-row:last-child{border-bottom:none}
.pay-label{font-size:13px;color:var(--ink-2);display:flex;align-items:center;gap:8px}
.pay-label::before{content:'';width:8px;height:8px;border-radius:50%;background:var(--dim)}
.pay-row.pos .pay-label::before{background:var(--g-grn)}
.pay-row.warn .pay-label::before{background:var(--g-yel)}
.pay-row.bad .pay-label::before{background:var(--g-red)}
.pay-row.neutral .pay-label::before{background:var(--dim)}
.pay-val{font-family:'Roboto Mono';font-size:14px;font-weight:500}

/* ─────────────────────────────────────────────────── RIDER BUILDER */
.rider-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}
@media (max-width:900px){.rider-grid{grid-template-columns:1fr}}
.rider-section{background:var(--surface);border:1px solid var(--border);border-radius:var(--r-lg);overflow:hidden}
.rider-section-head{padding:16px 20px;border-bottom:1px solid var(--border-soft);display:flex;align-items:center;justify-content:space-between;background:var(--surface-2)}
.rider-section-title{font-family:'Google Sans';font-size:14px;font-weight:500}
.rider-section-meta{font-size:11px;font-family:'Roboto Mono';color:var(--muted)}
.rider-list{padding:8px 16px}
.rider-row{display:flex;align-items:center;gap:12px;padding:10px 4px;border-bottom:1px solid var(--border-soft);font-size:13px;cursor:pointer}
.rider-row:last-child{border-bottom:none}
.rider-check{width:18px;height:18px;border-radius:5px;border:2px solid var(--border-hover);display:flex;align-items:center;justify-content:center;font-size:11px;color:#fff;transition:all var(--t);flex-shrink:0;background:var(--surface)}
.rider-row.checked .rider-check{background:var(--g-grn);border-color:var(--g-grn)}
.rider-row.checked .rider-text{color:var(--muted);text-decoration:line-through}
.rider-text{flex:1;color:var(--ink-2)}

/* ─────────────────────────────────────────────────── COMPARE */
.cmp-table{width:100%;border-collapse:collapse;margin-bottom:24px;background:var(--surface);border:1px solid var(--border);border-radius:var(--r-lg);overflow:hidden}
.cmp-table th{font-size:11px;font-family:'Roboto Mono';text-transform:uppercase;letter-spacing:0.08em;color:var(--muted);text-align:left;padding:14px 18px;border-bottom:1px solid var(--border-soft);background:var(--surface-2);font-weight:500}
.cmp-table th:not(:first-child){text-align:center}
.cmp-table th.sf{color:var(--gold-h);background:var(--gold-bg)}
.cmp-table td{padding:14px 18px;font-size:13px;border-bottom:1px solid var(--border-soft)}
.cmp-table td:not(:first-child){text-align:center}
.cmp-table tr:last-child td{border-bottom:none}
.cmp-table .sf{background:var(--gold-bg)}
.cmp-y{color:var(--g-grn);font-weight:500;font-size:16px}
.cmp-n{color:var(--whisper);font-size:16px}
.cmp-p{color:var(--g-yel-ink);font-weight:500}

/* Cards split for compare */
.cmp-cards{display:grid;grid-template-columns:repeat(3,1fr);gap:14px;margin-bottom:24px}
@media (max-width:900px){.cmp-cards{grid-template-columns:1fr}}
.cmp-card{padding:20px;background:var(--surface);border:1px solid var(--border);border-radius:var(--r-lg);position:relative;transition:all var(--t)}
.cmp-card:hover{border-color:var(--gold);box-shadow:var(--shadow-md)}
.cmp-card.featured{background:linear-gradient(135deg,#022B18 0%,#004D2E 40%,#003366 100%);color:#fff;border:none;position:relative;overflow:hidden}
.cmp-card.featured::after{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent,var(--gold-light) 50%,transparent)}
.cmp-card-tag{display:inline-block;font-size:10px;font-family:'Roboto Mono';text-transform:uppercase;letter-spacing:0.1em;padding:3px 10px;border-radius:100px;background:var(--surface-2);color:var(--muted);margin-bottom:10px;font-weight:500}
.cmp-card.featured .cmp-card-tag{background:var(--gold-bg);color:var(--gold-light);border:1px solid var(--gold)}
.cmp-card-price{font-family:'Google Sans';font-size:32px;font-weight:500;letter-spacing:-0.5px;line-height:1;margin-bottom:4px}
.cmp-card-suffix{font-size:13px;color:var(--muted);font-weight:400}
.cmp-card.featured .cmp-card-suffix{color:rgba(255,255,255,0.7)}
.cmp-card-desc{font-size:12px;color:var(--muted);margin:8px 0 14px;line-height:1.5}
.cmp-card.featured .cmp-card-desc{color:rgba(255,255,255,0.8)}
.cmp-list{list-style:none;display:flex;flex-direction:column;gap:8px;font-size:12px}
.cmp-list li{display:flex;align-items:flex-start;gap:8px;color:var(--ink-2)}
.cmp-card.featured .cmp-list li{color:rgba(255,255,255,0.92)}
.cmp-list li::before{content:'✓';color:var(--g-grn);font-weight:700;flex-shrink:0}
.cmp-card.featured .cmp-list li::before{color:var(--gold-light)}

/* ─────────────────────────────────────────────────── MODAL */
.overlay{position:fixed;inset:0;background:rgba(32,33,36,0.55);backdrop-filter:blur(4px);z-index:300;display:flex;align-items:center;justify-content:center;opacity:0;pointer-events:none;transition:opacity var(--t-slow);padding:16px}
.overlay.open{opacity:1;pointer-events:all}
.modal{background:var(--surface);border-radius:var(--r-xl);width:520px;max-width:100%;max-height:90vh;overflow-y:auto;transform:scale(0.94) translateY(12px);transition:transform var(--t-slow);box-shadow:var(--shadow-lg);border:1px solid var(--border);position:relative}
.modal::before{content:'';position:absolute;top:0;left:24px;right:24px;height:1px;background:linear-gradient(90deg,transparent,var(--gold) 50%,transparent)}
.overlay.open .modal{transform:scale(1) translateY(0)}
.modal-head{padding:24px 28px 4px;display:flex;align-items:flex-start;justify-content:space-between;gap:12px}
.modal-title{font-family:'Google Sans';font-size:20px;font-weight:500;letter-spacing:-0.3px}
.modal-close{width:32px;height:32px;border-radius:50%;border:none;background:transparent;cursor:pointer;color:var(--muted);display:flex;align-items:center;justify-content:center;transition:all var(--t);flex-shrink:0}
.modal-close:hover{background:var(--surface-2);color:var(--ink)}
.modal-sub{font-size:13px;color:var(--muted);padding:0 28px 18px}
.modal-body{padding:0 28px 24px}
.modal-foot{padding:16px 28px;border-top:1px solid var(--border-soft);display:flex;gap:8px;justify-content:flex-end;background:var(--surface-2)}

/* Form fields */
.field{margin-bottom:14px}
.field-row{display:grid;grid-template-columns:1fr 1fr;gap:12px}
.field-label{display:block;font-size:11px;font-family:'Roboto Mono';color:var(--muted);text-transform:uppercase;letter-spacing:0.08em;font-weight:500;margin-bottom:6px}
.field-input{width:100%;height:40px;padding:0 14px;border:1px solid var(--border);background:var(--surface);border-radius:var(--r);font-size:13px;color:var(--ink);outline:none;transition:all var(--t);font-family:inherit}
.field-input:focus{border-color:var(--g-blue);box-shadow:0 0 0 3px var(--g-blue-soft)}
select.field-input{cursor:pointer;appearance:none;background-image:url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%235F6368' stroke-width='2'><polyline points='6 9 12 15 18 9'/></svg>");background-repeat:no-repeat;background-position:right 12px center;padding-right:36px}

/* Gig detail modal extras */
.detail-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:14px;margin-bottom:18px}
.detail-tile{padding:12px;background:var(--surface-2);border-radius:var(--r-md);border:1px solid var(--border-soft)}
.detail-tile-label{font-size:10px;font-family:'Roboto Mono';color:var(--muted);text-transform:uppercase;letter-spacing:0.08em;margin-bottom:4px;font-weight:500}
.detail-tile-val{font-size:14px;font-weight:500;color:var(--ink)}
.detail-tile-val.gold{color:var(--gold-h);font-family:'Roboto Mono'}

/* Toast */
.toast{position:fixed;bottom:24px;right:24px;background:var(--ink);color:#fff;padding:14px 20px;border-radius:var(--r-md);font-size:13px;font-weight:500;box-shadow:var(--shadow-lg);transform:translateY(80px);opacity:0;transition:all var(--t-slow);z-index:400;display:flex;align-items:center;gap:10px;border:1px solid var(--gold);max-width:90vw}
.toast.show{transform:translateY(0);opacity:1}
.toast .icon{color:var(--gold)}

/* Notification panel */
.notif-panel{position:fixed;top:60px;right:24px;width:360px;max-width:90vw;background:var(--surface);border:1px solid var(--border);border-radius:var(--r-lg);box-shadow:var(--shadow-lg);z-index:280;opacity:0;pointer-events:none;transform:translateY(-8px);transition:all var(--t);max-height:480px;overflow:hidden;display:flex;flex-direction:column}
.notif-panel.open{opacity:1;pointer-events:all;transform:translateY(0)}
.notif-panel::before{content:'';position:absolute;top:0;left:16px;right:16px;height:1px;background:linear-gradient(90deg,transparent,var(--gold) 50%,transparent)}
.notif-head{padding:14px 18px;border-bottom:1px solid var(--border-soft);display:flex;align-items:center;justify-content:space-between}
.notif-title{font-family:'Google Sans';font-size:14px;font-weight:500}
.notif-list{flex:1;overflow-y:auto;padding:6px 0}
.notif-empty{padding:32px 20px;text-align:center;color:var(--muted);font-size:13px}

/* ─────────────────────────────────────────────────── VIEW SWITCHING */
.view{display:none}
.view.active{display:block}

/* ─────────────────────────────────────────────────── RESPONSIVE */
.scrim{position:fixed;inset:0;background:rgba(0,0,0,0.4);z-index:40;opacity:0;pointer-events:none;transition:opacity var(--t)}
.scrim.show{opacity:1;pointer-events:all}

@media (max-width:880px){
  .sidebar{position:fixed;left:0;top:0;transform:translateX(-100%);box-shadow:var(--shadow-lg);width:280px}
  .sidebar.open{transform:translateX(0)}
  .menu-btn{display:flex}
  .topbar{padding:10px 14px;gap:8px}
  .page{padding:16px 14px 32px}
  .page-title{font-size:24px}
  .hero-card{padding:18px}
  .hero-name{font-size:24px}
  .hero-stats-row{gap:14px;padding:10px 14px}
  .hero-stat-val{font-size:18px}
  .chart-card{padding:18px}
  .chart-big{font-size:26px}
  .field-row{grid-template-columns:1fr}
  .detail-grid{grid-template-columns:1fr 1fr}
  .tbl thead{display:none}
  .tbl tbody td{padding:10px 14px;font-size:12px}
  .kbd{display:none}
  .search input{padding-right:14px}
}
@media (max-width:480px){
  .page{padding:12px 12px 32px}
  .pipeline{gap:10px}
  .kanban-col{padding:10px}
}

/* ── LOGIN SCREEN ────────────────────────── */
.login-screen{position:fixed;inset:0;z-index:10000;background:linear-gradient(160deg,#0a1a0f 0%,#0d1f3c 55%,#1a0a00 100%);display:flex;align-items:center;justify-content:center;font-family:'Google Sans','Roboto',sans-serif}
.login-box{width:440px;max-width:92vw;background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.10);border-radius:24px;padding:40px;backdrop-filter:blur(20px);position:relative;overflow:hidden}
.login-box::before{content:'';position:absolute;top:0;left:40px;right:40px;height:1px;background:linear-gradient(90deg,transparent,var(--gold-light,#E8DBB7) 50%,transparent)}
.login-logo{text-align:center;margin-bottom:28px}
.login-logo-mark{width:64px;height:64px;border-radius:16px;background:linear-gradient(135deg,#007A4D 0%,#FFB612 45%,#DE3831 70%,#002395 100%);display:flex;align-items:center;justify-content:center;font-size:32px;font-weight:700;color:#fff;margin:0 auto 14px;box-shadow:0 8px 32px rgba(0,122,77,0.4)}
.login-wordmark{font-size:26px;font-weight:500;letter-spacing:-0.5px}
.login-wordmark .l1{color:#007A4D}.login-wordmark .l2{color:#DE3831}.login-wordmark .l3{color:#FFB612}.login-wordmark .l4{color:#002395}.login-wordmark .l5{color:#007A4D}.login-wordmark .l6{color:#DE3831}.login-wordmark .l7{color:#FFB612}
.login-sub{font-size:11px;letter-spacing:0.2em;text-transform:uppercase;color:rgba(255,255,255,0.35);font-family:'Roboto Mono',monospace;margin-top:4px}
.login-roles{display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-bottom:28px}
.role-btn{padding:16px 14px;border-radius:14px;border:1px solid rgba(255,255,255,0.12);background:rgba(255,255,255,0.04);cursor:pointer;transition:all 0.2s;text-align:left;color:#fff}
.role-btn:hover{border-color:rgba(201,169,97,0.6);background:rgba(201,169,97,0.08)}
.role-btn.selected{border-color:#C9A961;background:rgba(201,169,97,0.14);box-shadow:0 0 0 1px rgba(201,169,97,0.4)}
.role-btn-icon{font-size:24px;margin-bottom:8px}
.role-btn-name{font-size:13px;font-weight:500}
.role-btn-desc{font-size:11px;color:rgba(255,255,255,0.45);margin-top:2px}
.login-form .field-label{color:rgba(255,255,255,0.5);font-family:'Roboto Mono',monospace;font-size:10px;letter-spacing:0.1em;text-transform:uppercase;display:block;margin-bottom:6px}
.login-form .field-input{background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.12);color:#fff;border-radius:10px;width:100%;height:44px;padding:0 16px;font-size:14px;outline:none;transition:border-color 0.2s;font-family:inherit}
.login-form .field-input::placeholder{color:rgba(255,255,255,0.25)}
.login-form .field-input:focus{border-color:#C9A961}
.login-form .field{margin-bottom:14px}
.login-btn{width:100%;height:48px;background:linear-gradient(135deg,#D4B97E 0%,#C9A961 50%,#B89548 100%);border:none;border-radius:12px;color:#000;font-size:15px;font-weight:600;cursor:pointer;transition:all 0.2s;font-family:inherit;letter-spacing:0.01em;margin-top:6px}
.login-btn:hover{box-shadow:0 4px 20px rgba(201,169,97,0.45);transform:translateY(-1px)}
.login-err{color:#FF6B6B;font-size:12px;font-family:'Roboto Mono',monospace;text-align:center;margin-top:10px;min-height:18px}
.login-perms{margin-top:16px;padding:12px 16px;background:rgba(255,255,255,0.04);border-radius:10px;border:1px solid rgba(255,255,255,0.07)}
.login-perms-title{font-size:10px;color:rgba(255,255,255,0.4);font-family:'Roboto Mono',monospace;text-transform:uppercase;letter-spacing:0.1em;margin-bottom:6px}
.perm-item{display:flex;align-items:center;gap:8px;font-size:12px;color:rgba(255,255,255,0.65);margin-bottom:4px}
.perm-item::before{content:'';width:6px;height:6px;border-radius:50%;flex-shrink:0}
.perm-item.allow::before{background:#34A853}
.perm-item.deny::before{background:#EA4335}

/* ── RIDER BUILDER EDITABLE ──────────────── */
.rider-section-head .rider-add-btn{font-size:11px;font-family:'Roboto Mono',monospace;padding:4px 10px;border-radius:100px;border:1px solid var(--border);background:transparent;cursor:pointer;color:var(--muted);transition:all 0.15s;display:flex;align-items:center;gap:4px}
.rider-section-head .rider-add-btn:hover{background:var(--g-grn-bg);color:var(--g-grn);border-color:var(--g-grn-bd)}
.rider-row .rider-del{margin-left:auto;width:22px;height:22px;border-radius:50%;border:none;background:transparent;cursor:pointer;color:var(--whisper);display:flex;align-items:center;justify-content:center;font-size:14px;transition:all 0.15s;flex-shrink:0;opacity:0}
.rider-row:hover .rider-del{opacity:1}
.rider-del:hover{background:var(--g-red-bg);color:var(--g-red)!important}
.rider-edit-input{flex:1;border:none;background:transparent;color:var(--ink-2);font-size:13px;font-family:inherit;outline:none;padding:0}
.rider-edit-input:focus{color:var(--ink)}
.rider-section-head-edit{display:flex;align-items:center;gap:8px;flex:1}
.rider-section-name-input{border:none;background:transparent;font-family:'Google Sans';font-size:14px;font-weight:500;color:var(--ink);outline:none;cursor:text;flex:1}
.rider-section-name-input:focus{border-bottom:1px solid var(--gold)}
.rider-add-section-btn{display:flex;align-items:center;gap:8px;padding:12px 20px;background:var(--surface);border:2px dashed var(--border);border-radius:var(--r-lg);cursor:pointer;font-size:13px;color:var(--muted);transition:all 0.15s;width:100%;justify-content:center;margin-top:14px}
.rider-add-section-btn:hover{border-color:var(--gold);color:var(--gold-h);background:var(--gold-bg)}
.rider-del-section{font-size:11px;padding:3px 8px;border-radius:6px;border:1px solid var(--border);background:transparent;cursor:pointer;color:var(--dim);transition:all 0.15s}
.rider-del-section:hover{background:var(--g-red-bg);color:var(--g-red);border-color:var(--g-red-bd)}

</style>
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
</head>
<body>


<!-- ════════════════════════════════════════════════════ LOGIN SCREEN ══ -->
<div class="login-screen" id="loginScreen">
  <div class="login-box">
    <div class="login-logo">
      <div class="login-logo-mark">S</div>
      <div class="login-wordmark"><span class="l1">S</span><span class="l2">e</span><span class="l3">t</span><span class="l4">F</span><span class="l5">l</span><span class="l6">o</span><span class="l7">w</span></div>
      <div class="login-sub">Your stage is set. Press Play.</div>
    </div>
    <div class="login-roles">
      <div class="role-btn" id="role-manager" onclick="selectRole('manager')">
        <div class="role-btn-icon">👔</div>
        <div class="role-btn-name">Manager</div>
        <div class="role-btn-desc">Full platform access</div>
      </div>
      <div class="role-btn" id="role-artist" onclick="selectRole('artist')">
        <div class="role-btn-icon">🎧</div>
        <div class="role-btn-name">Artist</div>
        <div class="role-btn-desc">Your bookings & rider</div>
      </div>
    </div>
    <div class="login-form">
      <div class="field" id="login-name-field" style="display:none">
        <label class="field-label">Full name</label>
        <input class="field-input" type="text" id="login-name" placeholder="Your name" autocomplete="name"/>
      </div>
      <div class="field">
        <label class="field-label">Email</label>
        <input class="field-input" type="email" id="login-email" placeholder="you@setflow.co.za" autocomplete="email"/>
      </div>
      <div class="field">
        <label class="field-label">Password</label>
        <input class="field-input" type="password" id="login-pass" placeholder="••••••••" autocomplete="current-password" onkeydown="if(event.key==='Enter')doLogin()"/>
      </div>
      <button class="login-btn" onclick="doLogin()">Press Play →</button>
      <div class="login-err" id="login-err"></div>
      <div id="login-toggle" style="text-align:center;font-size:12px;color:rgba(255,255,255,0.5);margin-top:14px;font-family:'Roboto Mono',monospace;letter-spacing:0.05em">
        Don't have an account? <a href="#" style="color:#FFB612;text-decoration:none" onclick="event.preventDefault();toggleAuthMode()">Create one</a>
      </div>
    </div>
    <div class="login-perms" id="login-perms" style="display:none">
      <div class="login-perms-title">Permissions for this role</div>
      <div id="login-perms-list"></div>
    </div>
  </div>
</div>

<!-- ════════════════════════════════════════════════════ PRELOADER ══ -->
<div id="preloader" style="
  position:fixed;inset:0;z-index:9999;
  background:linear-gradient(160deg,#0a1a0f 0%,#0d1f3c 55%,#1a0a00 100%);
  display:flex;flex-direction:column;align-items:center;justify-content:center;
  font-family:'Google Sans','Roboto',sans-serif;
  transition:opacity 0.55s ease, transform 0.55s ease;
">
  <!-- SA flag stripe across top -->
  <div style="position:absolute;top:0;left:0;right:0;height:4px;background:linear-gradient(90deg,#007A4D 0 25%,#FFB612 25% 50%,#DE3831 50% 75%,#002395 75% 100%)"></div>

  <!-- Logo mark -->
  <div style="
    width:72px;height:72px;border-radius:18px;
    background:linear-gradient(135deg,#007A4D 0%,#FFB612 45%,#DE3831 70%,#002395 100%);
    display:flex;align-items:center;justify-content:center;
    font-size:36px;font-weight:700;color:#fff;
    box-shadow:0 8px 40px rgba(0,122,77,0.5),0 2px 8px rgba(0,0,0,0.4);
    margin-bottom:22px;
    animation:prelogoPulse 1.8s ease-in-out infinite;
  ">S</div>

  <!-- Brand name -->
  <div style="font-size:28px;font-weight:500;letter-spacing:-0.5px;margin-bottom:6px">
    <span style="color:#007A4D">S</span><span style="color:#DE3831">e</span><span style="color:#FFB612">t</span><span style="color:#002395">F</span><span style="color:#007A4D">l</span><span style="color:#DE3831">o</span><span style="color:#FFB612">w</span>
  </div>
  <div style="font-size:11px;letter-spacing:0.22em;text-transform:uppercase;color:rgba(255,255,255,0.45);font-family:'Roboto Mono',monospace;margin-bottom:40px">Press Play.</div>

  <!-- Gig pre-load widget -->
  <div id="preload-widget" style="
    width:340px;max-width:90vw;
    background:rgba(255,255,255,0.05);
    border:1px solid rgba(255,255,255,0.10);
    border-radius:16px;
    padding:18px 20px;
    backdrop-filter:blur(12px);
    margin-bottom:32px;
  ">
    <div style="font-size:11px;text-transform:uppercase;letter-spacing:0.14em;color:rgba(255,255,255,0.4);font-family:'Roboto Mono',monospace;margin-bottom:12px">Loading your upcoming gigs</div>
    <div id="preload-gigs" style="display:flex;flex-direction:column;gap:8px"></div>
  </div>

  <!-- Progress bar -->
  <div style="width:220px;height:3px;background:rgba(255,255,255,0.10);border-radius:2px;overflow:hidden;margin-bottom:14px">
    <div id="preload-bar" style="height:100%;width:0%;background:linear-gradient(90deg,#007A4D,#FFB612,#DE3831);border-radius:2px;transition:width 0.18s ease"></div>
  </div>
  <div id="preload-status" style="font-size:11px;color:rgba(255,255,255,0.35);font-family:'Roboto Mono',monospace;letter-spacing:0.08em">Initialising workspace…</div>

  <!-- SA flag stripe across bottom -->
  <div style="position:absolute;bottom:0;left:0;right:0;height:4px;background:linear-gradient(90deg,#002395 0 25%,#DE3831 25% 50%,#FFB612 50% 75%,#007A4D 75% 100%)"></div>
</div>

<style>
@keyframes prelogoPulse{0%,100%{box-shadow:0 8px 40px rgba(0,122,77,0.5),0 2px 8px rgba(0,0,0,0.4)}50%{box-shadow:0 8px 60px rgba(255,182,18,0.55),0 2px 8px rgba(0,0,0,0.4)}}
@keyframes preGigIn{from{opacity:0;transform:translateX(-12px)}to{opacity:1;transform:translateX(0)}}
</style>

<div class="gold-bar"></div>

<!-- ════════════════════════════════════════════════════ SIDEBAR ══ -->
<aside class="sidebar" id="sidebar">

  <div class="brand">
    <div class="brand-mark">S</div>
    <div>
      <div class="brand-name"><span class="l1">S</span><span class="l2">e</span><span class="l3">t</span><span class="l4">F</span><span class="l5">l</span><span class="l6">o</span><span class="l7">w</span></div>
      <div class="brand-tag">Press Play.</div>
    </div>
  </div>

  <div class="workspace-block">
    <div class="workspace-label">Artist Workspace</div>
    <div class="artist-pill" id="artist-pill" onclick="toggleArtistMenu()">
      <div class="avatar bc" id="cur-avatar">BC</div>
      <div class="artist-info">
        <div class="artist-name" id="cur-name">Black Coffee</div>
        <div class="artist-genre" id="cur-genre">Afro House · Global</div>
      </div>
    </div>
    <div class="artist-menu" id="artist-menu"></div>
  </div>

  <nav class="nav-area">
    <div class="nav-group">Workspace</div>
    <div class="nav-item active" data-view="dashboard" onclick="navTo('dashboard',this)">
      <span class="nav-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor"><rect x="3" y="3" width="7" height="9" rx="1"/><rect x="14" y="3" width="7" height="5" rx="1"/><rect x="14" y="12" width="7" height="9" rx="1"/><rect x="3" y="16" width="7" height="5" rx="1"/></svg></span>
      Dashboard
    </div>
    <div class="nav-item" data-view="gigs" onclick="navTo('gigs',this)">
      <span class="nav-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor"><path d="M9 18V5l12-2v13"/><circle cx="6" cy="18" r="3"/><circle cx="18" cy="16" r="3"/></svg></span>
      Bookings
      <span class="nav-badge blue" id="nav-gigs-count">12</span>
    </div>
    <div class="nav-item" data-view="calendar" onclick="navTo('calendar',this)">
      <span class="nav-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg></span>
      Calendar
    </div>
    <div class="nav-item" data-view="map" onclick="navTo('map',this)">
      <span class="nav-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg></span>
      Tour Map
    </div>

    <div class="nav-group">Finance & Legal</div>
    <div class="nav-item" data-view="revenue" onclick="navTo('revenue',this)">
      <span class="nav-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg></span>
      Revenue
    </div>
    <div class="nav-item" data-view="contracts" onclick="navTo('contracts',this)">
      <span class="nav-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg></span>
      Contracts
      <span class="nav-badge red">3</span>
    </div>

    <div class="nav-group">Artist</div>
    <div class="nav-item" data-view="rider" onclick="navTo('rider',this)">
      <span class="nav-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor"><line x1="8" y1="6" x2="21" y2="6"/><line x1="8" y1="12" x2="21" y2="12"/><line x1="8" y1="18" x2="21" y2="18"/><line x1="3" y1="6" x2="3.01" y2="6"/><line x1="3" y1="12" x2="3.01" y2="12"/><line x1="3" y1="18" x2="3.01" y2="18"/></svg></span>
      Rider Builder
    </div>
    <div class="nav-item" data-view="team" onclick="navTo('team',this)">
      <span class="nav-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg></span>
      Team
    </div>

    <div class="nav-group">Insights</div>
    <div class="nav-item" data-view="compare" onclick="navTo('compare',this)">
      <span class="nav-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg></span>
      Why SetFlow / Pricing
      <span class="nav-badge gold">★</span>
    </div>
  </nav>

  <div class="sidebar-foot">
    <div class="plan-pill">PRO · MANAGER</div>
    <div class="user-row">
      <div class="avatar bc">SM</div>
      <div class="user-info">
        <div class="user-name">Shaun Mthombeni</div>
        <div class="user-role">Artist Manager · All Artists</div>
      </div>
      <button onclick="signOut()" title="Sign out" aria-label="Sign out"
        style="background:transparent;border:none;cursor:pointer;color:var(--muted);padding:6px;border-radius:6px;display:flex;align-items:center;justify-content:center;transition:all 120ms"
        onmouseover="this.style.background='var(--surface-2)';this.style.color='var(--g-red)'"
        onmouseout="this.style.background='transparent';this.style.color='var(--muted)'">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
          <polyline points="16 17 21 12 16 7"/>
          <line x1="21" y1="12" x2="9" y2="12"/>
        </svg>
      </button>
    </div>
  </div>
</aside>

<div class="scrim" id="scrim" onclick="closeSidebar()"></div>

<!-- ════════════════════════════════════════════════════ MAIN ══ -->
<main class="main">

  <header class="topbar">
    <button class="menu-btn" onclick="openSidebar()" aria-label="Menu">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
    </button>
    <div class="search">
      <span class="search-icon"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg></span>
      <input type="text" id="searchInput" placeholder="Search gigs, cities, promoters…" oninput="onSearch()"/>
      <span class="kbd">⌘ K</span>
    </div>
    <button class="icon-btn" onclick="toggleNotifs()" aria-label="Notifications">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>
      <span class="dot"></span>
    </button>
    <button class="icon-btn" aria-label="Settings">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg>
    </button>
    <div class="avatar bc" style="width:36px;height:36px;font-size:11px;cursor:pointer" title="Shaun Mthombeni">SM</div>
  </header>

  <!-- Notification Panel -->
  <div class="notif-panel" id="notifPanel">
    <div class="notif-head">
      <div class="notif-title">Notifications</div>
      <button class="btn ghost sm" onclick="markAllRead()">Mark all read</button>
    </div>
    <div class="notif-list" id="notifList"></div>
  </div>

  <!-- ════════════════════════════════════════════════ DASHBOARD ══ -->
  <section class="page view active" id="view-dashboard">

    <div class="page-head">
      <div>
        <div class="page-title">Dashboard</div>
        <div class="page-sub">Black Coffee · <b>14 confirmed</b> gigs in next 90 days · <b>R5.8M</b> locked revenue</div>
      </div>
      <div class="page-actions">
        <button class="btn" onclick="exportData()"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg> Export</button>
        <button class="btn primary" onclick="openModal('add')"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg> New booking</button>
      </div>
    </div>

    <div class="hero">
      <div class="hero-card feature">
        <div class="hero-greeting" id="hero-greeting">GOOD EVENING ✦</div>
        <div class="hero-name">Welcome back, Shaun.</div>
        <div style="font-size:11px;letter-spacing:0.2em;text-transform:uppercase;opacity:0.5;font-family:'Roboto Mono';margin-bottom:16px;margin-top:-10px">Press Play.</div>
        <div class="hero-stats-row">
          <div class="hero-stat-item">
            <div class="hero-stat-label">YTD Earnings</div>
            <div class="hero-stat-val" id="hero-ytd">R0<span class="delta">↑ 31%</span></div>
          </div>
          <div class="hero-stat-item">
            <div class="hero-stat-label">Avg Fee</div>
            <div class="hero-stat-val" id="hero-avg">R0<span class="delta">↑ 8%</span></div>
          </div>
          <div class="hero-stat-item">
            <div class="hero-stat-label">Cities '25</div>
            <div class="hero-stat-val" id="hero-cities">0</div>
          </div>
        </div>
        <div class="hero-cta-row">
          <div class="hero-pill urgent" onclick="navTo('gigs',document.querySelector('[data-view=gigs]'))"><span class="ball"></span>3 holds expiring soon</div>
          <div class="hero-pill" onclick="navTo('contracts',document.querySelector('[data-view=contracts]'))"><span class="ball"></span>3 contracts pending sig</div>
          <div class="hero-pill" onclick="openModal('add')"><span class="ball"></span>2 new inquiries</div>
        </div>
      </div>

      <div class="spark-grid">
        <div class="spark-card blue" onclick="navTo('gigs',document.querySelector('[data-view=gigs]'))">
          <div>
            <div class="spark-label">Confirmed</div>
            <div class="spark-row"><div class="spark-num" data-count="14">0</div><svg class="spark-svg" viewBox="0 0 60 24" preserveAspectRatio="none"><polyline fill="none" stroke="#1A73E8" stroke-width="1.5" points="0,18 8,16 16,17 24,12 32,14 40,8 48,9 60,4"/></svg></div>
          </div>
          <div class="spark-foot"><span class="up">↑ 22%</span> vs Q1</div>
        </div>
        <div class="spark-card yel">
          <div>
            <div class="spark-label">On hold</div>
            <div class="spark-row"><div class="spark-num" data-count="6">0</div><svg class="spark-svg" viewBox="0 0 60 24" preserveAspectRatio="none"><polyline fill="none" stroke="#F9AB00" stroke-width="1.5" points="0,12 8,14 16,11 24,16 32,10 40,13 48,8 60,11"/></svg></div>
          </div>
          <div class="spark-foot">R2.5M potential</div>
        </div>
        <div class="spark-card red" onclick="navTo('contracts',document.querySelector('[data-view=contracts]'))">
          <div>
            <div class="spark-label">Pending sig</div>
            <div class="spark-row"><div class="spark-num" data-count="3">0</div><svg class="spark-svg" viewBox="0 0 60 24" preserveAspectRatio="none"><polyline fill="none" stroke="#EA4335" stroke-width="1.5" points="0,8 8,12 16,10 24,14 32,11 40,16 48,13 60,18"/></svg></div>
          </div>
          <div class="spark-foot"><span class="down">↓</span> needs follow-up</div>
        </div>
        <div class="spark-card grn" onclick="navTo('revenue',document.querySelector('[data-view=revenue]'))">
          <div>
            <div class="spark-label">Deposits</div>
            <div class="spark-row"><div class="spark-num" data-count="142">0</div><svg class="spark-svg" viewBox="0 0 60 24" preserveAspectRatio="none"><polyline fill="none" stroke="#34A853" stroke-width="1.5" points="0,20 8,18 16,15 24,16 32,11 40,9 48,6 60,3"/></svg></div>
          </div>
          <div class="spark-foot"><span class="up">↑ 18%</span> this Q</div>
        </div>
      </div>
    </div>

    <!-- Revenue chart -->
    <div class="chart-card">
      <div class="chart-head">
        <div>
          <div class="chart-title">Revenue trend · Last 12 months</div>
          <div class="chart-big">$892,400<span class="chart-delta">↑ 31% YoY</span></div>
        </div>
        <div class="sec-tabs">
          <button class="sec-tab active" onclick="setChartRange('12M',this)">12M</button>
          <button class="sec-tab" onclick="setChartRange('6M',this)">6M</button>
          <button class="sec-tab" onclick="setChartRange('3M',this)">3M</button>
          <button class="sec-tab" onclick="setChartRange('YTD',this)">YTD</button>
        </div>
      </div>
      <div class="chart-svg-wrap" id="chartSvgWrap"></div>
      <div class="chart-legend">
        <div class="legend-item"><span class="legend-dot" style="background:#1A73E8"></span>Confirmed revenue</div>
        <div class="legend-item"><span class="legend-dot" style="background:#C9A961"></span>Locked + Holds projected</div>
        <div class="legend-item"><span class="legend-dot" style="background:#34A853"></span>Deposits received</div>
      </div>
    </div>

    <!-- Pipeline -->
    <div class="sec-head">
      <div>
        <div class="sec-title">Booking Pipeline</div>
        <div class="sec-meta" id="pipelineSum">Loading…</div>
      </div>
      <button class="btn ghost sm">View all <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"/></svg></button>
    </div>
    <div class="pipeline" id="pipelineBoard"></div>

    <!-- Activity + Upcoming split -->
    <div class="split">
      <div class="feed-card">
        <div class="feed-head">
          <div class="sec-title">Next 5 confirmed</div>
          <button class="btn ghost sm" onclick="navTo('gigs',document.querySelector('[data-view=gigs]'))">See all</button>
        </div>
        <div class="feed-list" id="upcomingList"></div>
      </div>
      <div class="feed-card">
        <div class="feed-head">
          <div class="sec-title">Activity feed</div>
          <button class="btn ghost sm">Filters</button>
        </div>
        <div class="feed-list" id="activityFeed"></div>
      </div>
    </div>

  </section>

  <!-- ════════════════════════════════════════════════ GIGS ══ -->
  <section class="page view" id="view-gigs">
    <div class="page-head">
      <div>
        <div class="page-title">Bookings</div>
        <div class="page-sub" id="gigsSubText">All bookings · 2025 season</div>
      </div>
      <div class="page-actions">
        <select class="btn" id="gigFilter" onchange="renderGigsTable()" style="cursor:pointer;height:36px">
          <option value="all">All status</option>
          <option value="confirmed">Confirmed</option>
          <option value="hold">On hold</option>
          <option value="inquiry">Inquiry</option>
        </select>

        <button class="btn" onclick="signInWithGoogle()" style="height:36px; padding:0 12px; cursor:pointer;">
          Sign in
        </button>

        <button class="btn primary" onclick="openModal('add')">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/>
          </svg> New booking
        </button>
      </div>
    </div>
    <div class="table-card">
      <table class="tbl" id="gigsTable"></table>
    </div>
  </section>

  <!-- ════════════════════════════════════════════════ CALENDAR ══ -->
  <section class="page view" id="view-calendar">
    <div class="page-head">
      <div>
        <div class="page-title">Calendar</div>
        <div class="page-sub">Tap any date to see bookings · Color-coded by status</div>
      </div>
    </div>
    <div class="cal-card">
      <div class="cal-toolbar">
        <div class="cal-month" id="calMonth">Month Year</div>
        <div class="cal-nav-grp">
          <button class="btn sm" onclick="calShift(-1)"><svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="15 18 9 12 15 6"/></svg></button>
          <button class="btn sm" onclick="calToday()">Today</button>
          <button class="btn sm" onclick="calShift(1)"><svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"/></svg></button>
        </div>
      </div>
      <div class="cal-grid" id="calGrid"></div>
      <div class="cal-detail empty" id="calDetail">Tap a date to see scheduled bookings</div>
    </div>
  </section>

  <!-- ════════════════════════════════════════════════ TOUR MAP ══ -->
  <section class="page view" id="view-map">
    <div class="page-head">
      <div>
        <div class="page-title">Tour Map</div>
        <div class="page-sub">Confirmed gigs on the map · 8 countries · 12 cities · 2025 season</div>
      </div>
      <div class="page-actions">
        <button class="btn">Export route PDF</button>
      </div>
    </div>
    <div class="map-card">
      <div id="worldMap" style="width:100%;min-height:490px;border-radius:var(--r-md);overflow:hidden;border:1px solid var(--border-soft);position:relative;background:var(--surface-2)">
        <div id="map-loading" style="position:absolute;inset:0;display:flex;align-items:center;justify-content:center;flex-direction:column;gap:10px;z-index:2;background:var(--surface-2)">
          <div style="width:36px;height:36px;border:3px solid var(--border);border-top-color:#007A4D;border-radius:50%;animation:spin 0.8s linear infinite"></div>
          <div style="font-size:12px;color:var(--muted);font-family:'Roboto Mono'">Loading tour map…</div>
        </div>
      </div>
      <div style="padding:6px 4px 2px;font-size:10px;color:var(--muted);font-family:'Roboto Mono';">Powered by © Google Maps · showing confirmed tour stops</div>
      <div class="map-stats" id="mapStats"></div>
    </div>
  </section>

  <!-- ════════════════════════════════════════════════ REVENUE ══ -->
  <section class="page view" id="view-revenue">
    <div class="page-head">
      <div>
        <div class="page-title">Revenue</div>
        <div class="page-sub">Multi-currency normalised to ZAR · FY 2025</div>
      </div>
      <div class="page-actions">
        <button class="btn">Sync to QuickBooks</button>
        <button class="btn gold">Export PDF report</button>
      </div>
    </div>
    <div class="hero" style="margin-bottom:16px">
      <div class="spark-grid" style="grid-template-columns:repeat(4,1fr)">
        <div class="spark-card grn">
          <div><div class="spark-label">YTD Gross</div><div class="spark-num" data-count="16" data-suffix="M" data-prefix="R">R0</div></div>
          <div class="spark-foot"><span class="up">↑ 31%</span> vs '24</div>
        </div>
        <div class="spark-card blue">
          <div><div class="spark-label">Avg / gig</div><div class="spark-num" data-count="350" data-suffix="k" data-prefix="R">R0</div></div>
          <div class="spark-foot"><span class="up">↑ 8%</span> last 12mo</div>
        </div>
        <div class="spark-card yel">
          <div><div class="spark-label">Pending</div><div class="spark-num" data-count="1570" data-suffix="k" data-prefix="R">R0</div></div>
          <div class="spark-foot">Due 30 days</div>
        </div>
        <div class="spark-card red">
          <div><div class="spark-label">Overdue</div><div class="spark-num" data-count="219" data-suffix="k" data-prefix="R">R0</div></div>
          <div class="spark-foot">2 invoices late</div>
        </div>
      </div>
    </div>
    <div class="rev-grid">
      <div class="chart-card" style="margin-bottom:0">
        <div class="chart-head">
          <div>
            <div class="chart-title">Revenue by region</div>
            <div class="chart-big">YTD breakdown</div>
          </div>
        </div>
        <div id="regionBars" style="margin-top:14px"></div>
      </div>
      <div class="chart-card" style="margin-bottom:0">
        <div class="chart-head">
          <div>
            <div class="chart-title">Payment tracker</div>
            <div class="chart-big">Live status</div>
          </div>
        </div>
        <div id="payTracker" style="margin-top:8px"></div>
      </div>
    </div>
  </section>

  <!-- ════════════════════════════════════════════════ CONTRACTS ══ -->
  <section class="page view" id="view-contracts">
    <div class="page-head">
      <div>
        <div class="page-title">Contracts</div>
        <div class="page-sub"><b>3 pending signature</b> · DocuSign + native e-sign enabled</div>
      </div>
      <div class="page-actions">
        <button class="btn primary"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg> New contract</button>
      </div>
    </div>
    <div class="table-card">
      <table class="tbl" id="contractsTable"></table>
    </div>
  </section>

  <!-- ════════════════════════════════════════════════ RIDER ══ -->
  <section class="page view" id="view-rider">
    <div class="page-head">
      <div>
        <div class="page-title">Rider Builder</div>
        <div class="page-sub">Standard touring rider · 2025 · Auto-attaches to all confirmed bookings</div>
      </div>
      <div class="page-actions">
        <button class="btn">Preview PDF</button>
        <button class="btn gold">Send to promoter</button>
      </div>
    </div>
    <div class="rider-grid" id="riderGrid"></div>
  </section>

  <!-- ════════════════════════════════════════════════ TEAM ══ -->
  <section class="page view" id="view-team">
    <div class="page-head">
      <div>
        <div class="page-title">Team & Permissions</div>
        <div class="page-sub">Artist · Manager · Booking agent · Tour staff · all see different views</div>
      </div>
      <div class="page-actions"><button class="btn primary">Invite team member</button></div>
    </div>
    <div class="table-card">
      <table class="tbl" id="teamTable"></table>
    </div>
  </section>

  <!-- ════════════════════════════════════════════════ COMPARE ══ -->
  <section class="page view" id="view-compare">
    <div class="page-head">
      <div>
        <div class="page-title">Plans &amp; Pricing</div>
        <div class="page-sub">From bedroom producer to global management firm · scale as you grow</div>
      </div>
      <div class="page-actions">
        <div style="display:flex;align-items:center;gap:6px;background:var(--surface-2);border:1px solid var(--border);border-radius:100px;padding:4px 6px">
          <button id="bill-monthly" onclick="setBilling('monthly')" style="border-radius:100px;padding:5px 14px;font-size:12px;font-weight:600;background:var(--ink);color:#fff;border:none;cursor:pointer;font-family:'Google Sans',sans-serif;transition:all 0.2s">Monthly</button>
          <button id="bill-annual" onclick="setBilling('annual')" style="border-radius:100px;padding:5px 14px;font-size:12px;font-weight:500;background:transparent;color:var(--ink-2);border:none;cursor:pointer;font-family:'Google Sans',sans-serif;transition:all 0.2s">Annual&nbsp;<span style="font-size:10px;color:#007A4D;font-weight:700">−17%</span></button>
        </div>
      </div>
    </div>

    <!-- Annual savings banner -->
    <div id="annual-banner" style="display:none;align-items:center;gap:10px;background:linear-gradient(90deg,rgba(0,122,77,0.08),rgba(0,122,77,0.04));border:1px solid rgba(0,122,77,0.2);border-radius:10px;padding:11px 16px;font-size:13px;color:#007A4D;margin-bottom:20px">
      <span style="font-size:18px">🎉</span> Annual billing active — you get <b>2 months free</b> on all plans. Billed as a single annual payment.
    </div>

    <!-- 4 Tier cards -->
    <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:28px">

      <!-- 1. Foundations -->
      <div class="cmp-card" style="position:relative">
        <div class="cmp-card-tag" style="color:#5F6368;background:#F1F3F4">Foundations</div>
        <div class="cmp-card-price" id="price-foundations">R950<span class="cmp-card-suffix">/ mo</span></div>
        <div style="font-size:10px;text-transform:uppercase;letter-spacing:0.1em;color:var(--muted);font-family:'Roboto Mono';margin:10px 0 4px">Target</div>
        <div style="font-size:12px;color:var(--ink-2);margin-bottom:12px;font-weight:500">Emerging / Local Artists</div>
        <div class="cmp-card-desc">Essential booking tools, zero overwhelm. Perfect for artists starting to book local club gigs.</div>
        <ul class="cmp-list">
          <li>Up to 20 bookings / year</li>
          <li>Basic pipeline kanban</li>
          <li>Calendar view</li>
          <li>Single artist profile</li>
          <li>Rider builder (read-only share)</li>
          <li>ZAR + 1 foreign currency</li>
          <li>Email support</li>
        </ul>
        <button style="width:100%;margin-top:16px;padding:10px;background:var(--surface-2);border:1px solid var(--border);border-radius:8px;font-size:13px;font-weight:500;color:var(--ink-2);cursor:pointer;font-family:'Google Sans',sans-serif;transition:all 0.2s" onmouseover="this.style.background='var(--surface-3)'" onmouseout="this.style.background='var(--surface-2)'">Get started free</button>
      </div>

      <!-- 2. Pro (featured) -->
      <div class="cmp-card featured" style="position:relative;border:2px solid #FFB612!important">
        <div style="position:absolute;top:-12px;left:50%;transform:translateX(-50%);background:#FFB612;color:#000;font-size:10px;font-weight:700;padding:3px 14px;border-radius:100px;letter-spacing:0.08em;white-space:nowrap;box-shadow:0 2px 8px rgba(255,182,18,0.4)">MOST POPULAR</div>
        <div class="cmp-card-tag">Pro</div>
        <div class="cmp-card-price" id="price-pro">R4 500<span class="cmp-card-suffix">/ mo</span></div>
        <div style="font-size:10px;text-transform:uppercase;letter-spacing:0.1em;color:rgba(255,255,255,0.4);font-family:'Roboto Mono';margin:10px 0 4px">Target</div>
        <div style="font-size:12px;color:rgba(255,255,255,0.85);margin-bottom:12px;font-weight:500">Touring Acts &amp; Headliners</div>
        <div class="cmp-card-desc">Full automation — hold expiry, multi-currency, e-sign, riders, and agent/manager split.</div>
        <ul class="cmp-list">
          <li>Unlimited bookings</li>
          <li>Multi-currency (EUR/USD/GBP/ZAR)</li>
          <li>Hold expiry automation</li>
          <li>Native e-sign contracts</li>
          <li>Full rider builder + PDF export</li>
          <li>Agent + manager permissions</li>
          <li>Tour map with route view</li>
          <li>Revenue analytics</li>
          <li>Priority support</li>
        </ul>
        <button style="width:100%;margin-top:16px;padding:10px;background:#FFB612;border:none;border-radius:8px;font-size:13px;font-weight:700;color:#000;cursor:pointer;font-family:'Google Sans',sans-serif;transition:all 0.2s;box-shadow:0 2px 12px rgba(255,182,18,0.35)" onmouseover="this.style.background='#FFC933'" onmouseout="this.style.background='#FFB612'">Start Pro trial →</button>
      </div>

      <!-- 3. Agency -->
      <div class="cmp-card" style="position:relative;border-color:var(--gold)">
        <div class="cmp-card-tag" style="color:#B8860B;background:#FFF8E1;border:1px solid #FFE082">Agency</div>
        <div class="cmp-card-price" id="price-agency">R10 500<span class="cmp-card-suffix">/ mo</span></div>
        <div style="font-size:10px;text-transform:uppercase;letter-spacing:0.1em;color:var(--muted);font-family:'Roboto Mono';margin:10px 0 4px">Target</div>
        <div style="font-size:12px;color:var(--ink-2);margin-bottom:12px;font-weight:500">Boutique Agencies (3–10 artists)</div>
        <div class="cmp-card-desc">Multi-artist workspace with full admin delegation and cross-roster reporting.</div>
        <ul class="cmp-list">
          <li>Everything in Pro</li>
          <li>Up to 10 artist profiles</li>
          <li>Multi-artist dashboard</li>
          <li>Role-based team access</li>
          <li>Admin delegation controls</li>
          <li>Bulk contract management</li>
          <li>Cross-artist revenue reports</li>
          <li>White-label PDF exports</li>
          <li>Dedicated account manager</li>
        </ul>
        <button style="width:100%;margin-top:16px;padding:10px;background:var(--surface-2);border:1px solid var(--gold);border-radius:8px;font-size:13px;font-weight:500;color:var(--gold-h);cursor:pointer;font-family:'Google Sans',sans-serif;transition:all 0.2s" onmouseover="this.style.background='var(--gold-bg)'" onmouseout="this.style.background='var(--surface-2)'">Talk to us</button>
      </div>

      <!-- 4. Enterprise -->
      <div class="cmp-card" style="position:relative;background:linear-gradient(160deg,#0a1a0f,#001A4D);border-color:rgba(255,255,255,0.12)">
        <div class="cmp-card-tag" style="color:rgba(255,255,255,0.55);background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.15)">Enterprise</div>
        <div class="cmp-card-price" style="color:#fff" id="price-enterprise">Custom</div>
        <div style="font-size:10px;text-transform:uppercase;letter-spacing:0.1em;color:rgba(255,255,255,0.3);font-family:'Roboto Mono';margin:10px 0 4px">Target</div>
        <div style="font-size:12px;color:rgba(255,255,255,0.65);margin-bottom:12px;font-weight:500">Global Management Firms</div>
        <div class="cmp-card-desc" style="color:rgba(255,255,255,0.5)">API access, white-labelling, audit trails, and SLA guarantees. Priced per engagement.</div>
        <ul class="cmp-list">
          <li style="color:rgba(255,255,255,0.65)">Everything in Agency</li>
          <li style="color:rgba(255,255,255,0.65)">Unlimited artists &amp; users</li>
          <li style="color:rgba(255,255,255,0.65)">Full REST API access</li>
          <li style="color:rgba(255,255,255,0.65)">White-label branding</li>
          <li style="color:rgba(255,255,255,0.65)">Audit trails &amp; compliance logs</li>
          <li style="color:rgba(255,255,255,0.65)">SSO / SAML integration</li>
          <li style="color:rgba(255,255,255,0.65)">99.9% uptime SLA</li>
          <li style="color:rgba(255,255,255,0.65)">Dedicated solutions engineer</li>
        </ul>
        <button style="width:100%;margin-top:16px;padding:10px;background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.18);border-radius:8px;font-size:13px;font-weight:500;color:rgba(255,255,255,0.85);cursor:pointer;font-family:'Google Sans',sans-serif;transition:all 0.2s" onmouseover="this.style.background='rgba(255,255,255,0.14)'" onmouseout="this.style.background='rgba(255,255,255,0.08)'">Book a call →</button>
      </div>
    </div>

    <!-- Pricing footnote -->
    <div style="text-align:center;font-size:11px;color:var(--muted);font-family:'Roboto Mono';margin-bottom:28px;letter-spacing:0.04em">
      All prices in ZAR · VAT excluded · Annual billing saves 2 months · Cancel anytime
    </div>

    <!-- Feature comparison table -->
    <div class="sec-head"><div class="sec-title">Full feature comparison</div><div class="sec-sub">SetFlow tiers vs the alternatives</div></div>
    <div style="overflow-x:auto;margin-bottom:28px">
      <table class="cmp-table" style="min-width:760px">
        <thead>
          <tr>
            <th style="width:28%">Feature</th>
            <th>Foundations</th>
            <th class="sf">Pro ★</th>
            <th class="sf">Agency</th>
            <th class="sf">Enterprise</th>
            <th>Gigwell</th>
            <th>Spreadsheet</th>
          </tr>
        </thead>
        <tbody id="cmpBody"></tbody>
      </table>
    </div>

    <!-- Wedge cards -->
    <div class="cmp-cards" style="grid-template-columns:1fr 1fr">
      <div class="cmp-card">
        <div class="cmp-card-tag" style="color:var(--g-red);background:var(--g-red-bg)">Why not Gigwell or Muzeek?</div>
        <div style="font-size:13px;color:var(--ink-2);line-height:1.7;margin-top:6px">Built for US agency workflows. No multi-currency normalisation, no hold-expiry automation, rudimentary permission splits, and an enterprise CRM feel — not artist-first. <b>Zero presence in African electronic music.</b></div>
      </div>
      <div class="cmp-card" style="border-color:var(--gold)">
        <div class="cmp-card-tag" style="color:var(--gold-h);background:var(--gold-bg);border:1px solid var(--gold)">SetFlow's winning wedge</div>
        <div style="font-size:13px;color:var(--ink-2);line-height:1.7;margin-top:6px"><b>(1)</b> Afro house community — Black Coffee, Shimza, DBN Gogo deserve proper tools. <b>(2)</b> Multi-currency-first. <b>(3)</b> Artist-facing design. <b>(4)</b> Rider + e-sign in one place. <b>(5)</b> A pricing ladder that grows with every artist.</div>
      </div>
    </div>
  </section>

</main>

<!-- ════════════════════════════════════════════════════ ADD GIG MODAL ══ -->
<div class="overlay" id="modal-add" onclick="overlayClose(event,'add')">
  <div class="modal" onclick="event.stopPropagation()">
    <div class="modal-head">
      <div>
        <div class="modal-title">New booking</div>
      </div>
      <button class="modal-close" onclick="closeModal('add')"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg></button>
    </div>
    <div class="modal-sub">Add a new gig to the pipeline. Auto-attach rider on confirmation.</div>
    <div class="modal-body">
      <div class="field">
        <label class="field-label">Venue / Event</label>
        <input class="field-input" type="text" id="f-name" placeholder="e.g. Pacha Ibiza"/>
      </div>
      <div class="field-row">
        <div class="field"><label class="field-label">City</label><input class="field-input" id="f-city" placeholder="City"/></div>
        <div class="field"><label class="field-label">Country</label>
          <select class="field-input" id="f-country">
            <option value="🇪🇸">Spain 🇪🇸</option><option value="🇺🇸">USA 🇺🇸</option><option value="🇬🇧">UK 🇬🇧</option>
            <option value="🇩🇪">Germany 🇩🇪</option><option value="🇿🇦">South Africa 🇿🇦</option><option value="🇫🇷">France 🇫🇷</option>
            <option value="🇳🇱">Netherlands 🇳🇱</option><option value="🇧🇪">Belgium 🇧🇪</option><option value="🇬🇷">Greece 🇬🇷</option>
          </select>
        </div>
      </div>
      <div class="field-row">
        <div class="field"><label class="field-label">Date</label><input class="field-input" type="date" id="f-date"/></div>
        <div class="field"><label class="field-label">Type</label>
          <select class="field-input" id="f-type"><option>Club</option><option>Festival</option><option>Event</option></select>
        </div>
      </div>
      <div class="field-row">
        <div class="field"><label class="field-label">Status</label>
          <select class="field-input" id="f-status"><option value="inquiry">Inquiry</option><option value="hold">On hold</option><option value="confirmed">Confirmed</option></select>
        </div>
        <div class="field"><label class="field-label">Promoter</label><input class="field-input" id="f-promoter" placeholder="Promoter name"/></div>
      </div>
      <div class="field-row">
        <div class="field"><label class="field-label">Fee</label><input class="field-input" type="number" id="f-fee" placeholder="45000"/></div>
        <div class="field"><label class="field-label">Currency</label>
          <select class="field-input" id="f-cur"><option>ZAR</option><option>USD</option><option>EUR</option><option>GBP</option></select>
        </div>
      </div>
    </div>
    <div class="modal-foot">
      <button class="btn ghost" onclick="closeModal('add')">Cancel</button>
      <button class="btn primary" onclick="saveGig()">Save booking</button>
    </div>
  </div>
</div>

<!-- ════════════════════════════════════════════════════ GIG DETAIL MODAL ══ -->
<div class="overlay" id="modal-detail" onclick="overlayClose(event,'detail')">
  <div class="modal" onclick="event.stopPropagation()">
    <div class="modal-head">
      <div>
        <div class="modal-title" id="d-title">—</div>
      </div>
      <button class="modal-close" onclick="closeModal('detail')"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg></button>
    </div>
    <div class="modal-sub" id="d-sub">—</div>
    <div class="modal-body">
      <div class="detail-grid">
        <div class="detail-tile"><div class="detail-tile-label">Status</div><div class="detail-tile-val" id="d-status">—</div></div>
        <div class="detail-tile"><div class="detail-tile-label">Fee</div><div class="detail-tile-val gold" id="d-fee">—</div></div>
        <div class="detail-tile"><div class="detail-tile-label">Type</div><div class="detail-tile-val" id="d-type">—</div></div>
        <div class="detail-tile"><div class="detail-tile-label">Promoter</div><div class="detail-tile-val" id="d-prom">—</div></div>
        <div class="detail-tile"><div class="detail-tile-label">Contract</div><div class="detail-tile-val" id="d-contract">—</div></div>
        <div class="detail-tile"><div class="detail-tile-label">Deposit</div><div class="detail-tile-val" id="d-dep">—</div></div>
      </div>
      <div style="background:var(--surface-2);border:1px solid var(--border-soft);border-radius:var(--r-md);padding:14px;font-size:13px;color:var(--ink-2);line-height:1.5">
        <strong style="font-family:'Google Sans';display:block;margin-bottom:6px">Quick actions</strong>
        Send rider · Generate contract · Set hold expiry · Add to tour route · Sync to calendar
      </div>
    </div>
    <div class="modal-foot">
      <button class="btn ghost" onclick="closeModal('detail')">Close</button>
      <button class="btn">Edit</button>
      <button class="btn primary">Send rider</button>
    </div>
  </div>
</div>

<!-- Toast -->
<div class="toast" id="toast"><span class="icon">✦</span><span id="toastMsg">Done.</span></div>

<script>
/* ═══════════════════════════════════════════════════ SUPABASE ═══ */
/* Anon key — intentionally public. Security via Row Level Security policies.
   See: https://supabase.com/docs/guides/api/api-keys
   Project: DNH-MUSIC / SetFlow / main */
const SUPABASE_URL  = "https://mqmzrxjpelgmdjolohmw.supabase.co";
const SUPABASE_ANON = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1xbXpyeGpwZWxnbWRqb2xvaG13Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzcxNDU1NDYsImV4cCI6MjA5MjcyMTU0Nn0.ujAjlaMiKSgp8MTTEXBw8iUa1PBovSWTk4jrIb6x2tE";
const sb = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON, {
  auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: true }
});
window.sb = sb; /* expose for console debugging */

/* ═══════════════════════════════════════════════════ DATA ═══ */
/* NOTE: ARTISTS + GIGS are now mutable. Real data loads from Supabase after auth.
   The seed values below are kept ONLY as a fallback for local-dev / preview. */
let ARTISTS = [
  {id:'bc',name:'Black Coffee',genre:'Afro House · Global',av:'BC',cls:'bc'},
  {id:'sh',name:'Shimza',genre:'Afro Tech · House',av:'SH',cls:'sh'},
  {id:'th',name:'Themba',genre:'Afro House · Melodic',av:'TH',cls:'th'},
  {id:'dg',name:'David Guetta',genre:'Commercial EDM',av:'DG',cls:'dg'},
];
let curArtist = 'bc';

let GIGS = [
  /* ── Existing bookings ─────────────────────────────────── */
  {id:1,name:'Club Space Miami',city:'Miami',flag:'🇺🇸',date:'2025-05-03',status:'confirmed',fee:22000,cur:'USD',deposit:true,contract:'signed',type:'Club',promoter:'Link Miami Rebels',lat:25.7617,lng:-80.1918,urgent:false,address:'34 NE 11th St, Miami, FL 33132'},
  {id:2,name:'Fabric London',city:'London',flag:'🇬🇧',date:'2025-05-10',status:'confirmed',fee:18000,cur:'GBP',deposit:true,contract:'signed',type:'Club',promoter:'Fabric Ltd',lat:51.5199,lng:-0.1006,urgent:false,address:'77a Charterhouse St, London EC1M 6HJ'},
  {id:3,name:'Watergate Berlin',city:'Berlin',flag:'🇩🇪',date:'2025-05-17',status:'hold',fee:15000,cur:'EUR',deposit:false,contract:'pending',type:'Club',promoter:'Watergate GmbH',lat:52.5121,lng:13.4434,urgent:true,address:'Falckensteinstraße 49, 10997 Berlin'},
  {id:4,name:'Scorpios Mykonos',city:'Mykonos',flag:'🇬🇷',date:'2025-05-24',status:'confirmed',fee:35000,cur:'EUR',deposit:true,contract:'signed',type:'Festival',promoter:'Soho House Group',lat:37.4476,lng:25.3483,urgent:false,address:'Paraga Beach, Mykonos 846 00, Greece'},
  {id:5,name:'Output NYC',city:'New York',flag:'🇺🇸',date:'2025-06-07',status:'inquiry',fee:25000,cur:'USD',deposit:false,contract:'none',type:'Club',promoter:'Output BK',lat:40.7128,lng:-73.9452,urgent:false,address:'74 Wythe Ave, Brooklyn, NY 11249'},
  {id:7,name:'Boiler Room Cape Town',city:'Cape Town',flag:'🇿🇦',date:'2025-06-21',status:'hold',fee:8000,cur:'USD',deposit:false,contract:'pending',type:'Event',promoter:'Boiler Room',lat:-33.9249,lng:18.4241,urgent:true,address:'V&A Waterfront, Cape Town'},
  {id:8,name:'Amnesia Ibiza',city:'Ibiza',flag:'🇪🇸',date:'2025-07-05',status:'confirmed',fee:50000,cur:'EUR',deposit:true,contract:'signed',type:'Club',promoter:'Amnesia',lat:38.9699,lng:1.4301,urgent:false,address:"Ctra. Ibiza-Sant Antoni, km 5, 07816 Sant Rafel de sa Creu, Illes Balears"},
  {id:9,name:'DC10 Ibiza',city:'Ibiza',flag:'🇪🇸',date:'2025-07-12',status:'confirmed',fee:40000,cur:'EUR',deposit:true,contract:'signed',type:'Club',promoter:'Circoloco',lat:38.8920,lng:1.3950,urgent:false,address:'Ctra. Ibiza a Aeropuerto, 07820 Sant Josep de sa Talaia'},
  {id:10,name:'Tomorrowland',city:'Boom',flag:'🇧🇪',date:'2025-07-19',status:'confirmed',fee:85000,cur:'EUR',deposit:true,contract:'signed',type:'Festival',promoter:'ID&T',lat:51.0892,lng:4.3572,urgent:false,address:'Schomstraat 200, 2850 Boom, Belgium'},
  {id:12,name:'Circoloco Amsterdam',city:'Amsterdam',flag:'🇳🇱',date:'2025-08-02',status:'inquiry',fee:20000,cur:'EUR',deposit:false,contract:'none',type:'Club',promoter:'Awakenings',lat:52.3676,lng:4.9041,urgent:false,address:'Distelweg 83, 1031 HG Amsterdam'},
  {id:13,name:'Coachella',city:'Palm Springs',flag:'🇺🇸',date:'2025-04-12',status:'confirmed',fee:95000,cur:'USD',deposit:true,contract:'signed',type:'Festival',promoter:'Goldenvoice',lat:33.6825,lng:-116.2380,urgent:false,address:'81-800 51st Ave, Indio, CA 92201'},
  {id:14,name:'Ultra Miami',city:'Miami',flag:'🇺🇸',date:'2025-03-29',status:'confirmed',fee:75000,cur:'USD',deposit:true,contract:'signed',type:'Festival',promoter:'Ultra Music',lat:25.7617,lng:-80.1870,urgent:false,address:'Bayfront Park, 301 Biscayne Blvd, Miami, FL 33132'},
  /* ── Spain — Ibiza venues ─────────────────────────────── */
  {id:20,name:'Hï Ibiza',city:'Ibiza',flag:'🇪🇸',date:'2025-06-28',status:'confirmed',fee:60000,cur:'EUR',deposit:true,contract:'signed',type:'Club',promoter:'ushuaïa Entertainment',lat:38.8763,lng:1.4064,urgent:false,address:'Ctra. Platja d\'en Bossa, 07817 Sant Josep de sa Talaia, Ibiza, Spain'},
  {id:11,name:'Ushuaïa Ibiza',city:'Ibiza',flag:'🇪🇸',date:'2025-07-26',status:'hold',fee:55000,cur:'EUR',deposit:false,contract:'pending',type:'Club',promoter:'Palladium',lat:38.8823,lng:1.4090,urgent:true,address:'Playa d\'en Bossa, 10, 07817 Ibiza, Balearic Islands, Spain'},
  {id:6,name:'Pacha Ibiza',city:'Ibiza',flag:'🇪🇸',date:'2025-06-14',status:'confirmed',fee:45000,cur:'EUR',deposit:true,contract:'signed',type:'Club',promoter:'Pacha Group',lat:38.9079,lng:1.4348,urgent:false,address:'Av. 8 d\'Agost, 07800 Eivissa, Illes Balears, Spain'},
  /* ── South Africa ─────────────────────────────────────── */
  {id:21,name:'The Club at Steyn City',city:'Johannesburg',flag:'🇿🇦',date:'2025-08-23',status:'confirmed',fee:350000,cur:'ZAR',deposit:true,contract:'signed',type:'Private',promoter:'Steyn City',lat:-25.9658,lng:28.0167,urgent:false,address:'2 Clubhouse Lane, Midrand, Johannesburg, 2191, South Africa'},
  {id:22,name:'Shimmy Beach Club',city:'Cape Town',flag:'🇿🇦',date:'2025-09-13',status:'inquiry',fee:180000,cur:'ZAR',deposit:false,contract:'none',type:'Club',promoter:'V&A Waterfront Events',lat:-33.9048,lng:18.4232,urgent:false,address:'12 S Arm Rd, V&A Waterfront, Cape Town, 8002, South Africa'},
  /* ── USA ──────────────────────────────────────────────── */
  {id:23,name:'LIV Nightclub Miami',city:'Miami Beach',flag:'🇺🇸',date:'2025-10-04',status:'confirmed',fee:35000,cur:'USD',deposit:true,contract:'signed',type:'Club',promoter:'LIV Entertainment',lat:25.7907,lng:-80.1300,urgent:false,address:'4441 Collins Ave, Miami Beach, FL 33140, USA'},
  {id:24,name:'XS Nightclub',city:'Las Vegas',flag:'🇺🇸',date:'2025-10-18',status:'inquiry',fee:50000,cur:'USD',deposit:false,contract:'none',type:'Club',promoter:'Encore Beach Club',lat:36.1265,lng:-115.1742,urgent:false,address:'3131 Las Vegas Blvd S, Las Vegas, NV 89109, USA'},
  {id:25,name:'Madison Square Garden',city:'New York',flag:'🇺🇸',date:'2025-11-15',status:'hold',fee:120000,cur:'USD',deposit:false,contract:'pending',type:'Festival',promoter:'MSG Live',lat:40.7505,lng:-73.9934,urgent:false,address:'4 Pennsylvania Plaza, New York, NY 10001, USA'},
  /* ── Dubai ────────────────────────────────────────────── */
  {id:26,name:'Ushuaïa Dubai Harbour',city:'Dubai',flag:'🇦🇪',date:'2025-09-27',status:'confirmed',fee:80000,cur:'USD',deposit:true,contract:'signed',type:'Festival',promoter:'Ushuaïa Entertainment',lat:25.0818,lng:55.1388,urgent:false,address:'Dubai Harbour, Dubai Marina, Dubai, UAE'},
  {id:27,name:'FIVE Luxe JBR',city:'Dubai',flag:'🇦🇪',date:'2025-10-11',status:'hold',fee:65000,cur:'USD',deposit:false,contract:'pending',type:'Club',promoter:'FIVE Hotels',lat:25.0764,lng:55.1292,urgent:false,address:'The Walk, Jumeirah Beach Residence, Dubai, UAE'},
  {id:28,name:'Soho Garden DXB',city:'Dubai',flag:'🇦🇪',date:'2025-11-01',status:'confirmed',fee:55000,cur:'USD',deposit:true,contract:'signed',type:'Club',promoter:'Soho House Group',lat:25.1585,lng:55.2419,urgent:false,address:'Al Meydan Rd, Nad Al Sheba 1, Dubai, UAE'},
];

const ACTIVITY = [
  {icon:'gold',sym:'⏱',text:'<b>Hold expiring in 36h</b> — Watergate Berlin · €15,000',time:'2h ago'},
  {icon:'green',sym:'✓',text:'<b>Deposit received</b> — Pacha Ibiza · €22,500 (50%)',time:'5h ago'},
  {icon:'blue',sym:'✉',text:'<b>New inquiry</b> — Output NYC · 7 Jun 2025',time:'8h ago'},
  {icon:'red',sym:'!',text:'<b>Contract reminder sent</b> — Boiler Room Cape Town · 2nd attempt',time:'1d ago'},
  {icon:'green',sym:'✓',text:'<b>Contract signed</b> — Tomorrowland · €85,000 locked',time:'1d ago'},
  {icon:'gold',sym:'★',text:'<b>Featured booking</b> — DC10 Ibiza confirmed for July',time:'2d ago'},
  {icon:'blue',sym:'⊞',text:'<b>Calendar synced</b> — Google Cal updated · 12 events',time:'2d ago'},
  {icon:'green',sym:'$',text:'<b>Payment cleared</b> — Coachella · $95,000 (full)',time:'3d ago'},
];

const NOTIFS = [
  {tone:'red',icon:'!',title:'Hold expires in 36h',body:'Watergate Berlin — €15,000. Confirm or release.',time:'2h'},
  {tone:'gold',icon:'⏱',title:'Hold expires in 4 days',body:'Boiler Room Cape Town — $8,000.',time:'5h'},
  {tone:'gold',icon:'⏱',title:'Hold expires in 6 days',body:'Ushuaïa Ibiza — €55,000.',time:'1d'},
  {tone:'red',icon:'$',title:'Invoice overdue',body:'$12,000 — Cape Town promoter, 14 days late.',time:'1d'},
  {tone:'blue',icon:'✉',title:'New inquiry from Output NYC',body:'June 7 — proposed $25,000.',time:'8h'},
];

/* RIDER moved below — see "RIDER BUILDER (FULL CRUD)" section. */

const TEAM = [
  {name:'Black Coffee',role:'Artist',cls:'bc',av:'BC',perms:'Full access',email:'artist@blackcoffee.co'},
  {name:'Shimza',role:'Artist',cls:'sh',av:'SH',perms:'Full access',email:'artist@shimza.co.za'},
  {name:'Themba',role:'Artist',cls:'th',av:'TH',perms:'Full access',email:'artist@iamthemba.com'},
  {name:'David Guetta',role:'Artist',cls:'dg',av:'DG',perms:'Full access',email:'artist@davidguetta.com'},
  {name:'Shaun Mthombeni',role:'Artist Manager',cls:'bc',av:'SM',perms:'Full access — all artists',email:'shaun@setflow.co.za'},
  {name:'Tina M.',role:'Manager',cls:'sh',av:'TM',perms:'Manage all',email:'tina@bc-mgmt.com'},
  {name:'James O.',role:'Booking Agent',cls:'th',av:'JO',perms:'Bookings + fees',email:'james@wmebooking.com'},
  {name:'Sara K.',role:'Tour Director',cls:'dg',av:'SK',perms:'Calendar + travel',email:'sara@bc-mgmt.com'},
];

const COMP = [
  {f:'Booking pipeline kanban',       fo:true,       pr:true,  ag:true,  en:true,  gw:true,       xl:'partial'},
  {f:'Calendar with gig dots',        fo:true,       pr:true,  ag:true,  en:true,  gw:true,       xl:'partial'},
  {f:'Multi-currency normalisation',  fo:'partial',  pr:true,  ag:true,  en:true,  gw:false,      xl:false},
  {f:'Hold expiry automation',        fo:false,      pr:true,  ag:true,  en:true,  gw:false,      xl:false},
  {f:'Native e-sign contracts',       fo:false,      pr:true,  ag:true,  en:true,  gw:true,       xl:false},
  {f:'Rider builder + PDF export',    fo:'partial',  pr:true,  ag:true,  en:true,  gw:'partial',  xl:false},
  {f:'Agent / manager permissions',   fo:false,      pr:true,  ag:true,  en:true,  gw:'partial',  xl:false},
  {f:'Multi-artist workspace',        fo:false,      pr:false, ag:true,  en:true,  gw:true,       xl:false},
  {f:'Revenue by region breakdown',   fo:false,      pr:true,  ag:true,  en:true,  gw:false,      xl:'partial'},
  {f:'Deposit tracker per gig',       fo:'partial',  pr:true,  ag:true,  en:true,  gw:'partial',  xl:'partial'},
  {f:'Tour map with route view',      fo:false,      pr:true,  ag:true,  en:true,  gw:false,      xl:false},
  {f:'White-label PDF exports',       fo:false,      pr:false, ag:true,  en:true,  gw:false,      xl:false},
  {f:'Full REST API access',          fo:false,      pr:false, ag:false, en:true,  gw:false,      xl:false},
  {f:'Audit trails & compliance',     fo:false,      pr:false, ag:false, en:true,  gw:false,      xl:false},
  {f:'Afro house / SA market focus',  fo:true,       pr:true,  ag:true,  en:true,  gw:false,      xl:false},
  {f:'Annual billing (2 mo free)',    fo:true,       pr:true,  ag:true,  en:true,  gw:false,      xl:false},
];

/* ═══════════════════════════════════════════════════ UTILS ═══ */
const fmtMoney=(n,c='ZAR')=>new Intl.NumberFormat('en-ZA',{style:'currency',currency:c,maximumFractionDigits:0}).format(n);
const fmtDate=s=>new Date(s+'T12:00:00').toLocaleDateString('en-US',{month:'short',day:'numeric',year:'numeric'});
const fmtDateShort=s=>new Date(s+'T12:00:00').toLocaleDateString('en-US',{month:'short',day:'numeric'});
const escapeHtml=s=>(s||'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'})[c]);

function badgeStatus(s){
  const map={confirmed:['b-confirmed','Confirmed'],hold:['b-hold','On hold'],inquiry:['b-inquiry','Inquiry'],cancelled:['b-cancelled','Cancelled']};
  const[c,l]=map[s]||['b-inquiry',s];
  return `<span class="badge ${c}">${l}</span>`;
}
function badgeContract(c){
  if(c==='signed')return '<span class="badge b-signed">Signed</span>';
  if(c==='pending')return '<span class="badge b-pending">Pending</span>';
  return '<span class="badge b-none">None</span>';
}
function depositCell(d){return d?'<span class="dep-yes">✓ Received</span>':'<span class="dep-no">— Awaited</span>'}

function showToast(msg){
  const t=document.getElementById('toast');
  document.getElementById('toastMsg').textContent=msg;
  t.classList.add('show');
  clearTimeout(window._tt);
  window._tt=setTimeout(()=>t.classList.remove('show'),2400);
}

/* ═══════════════════════════════════════════════════ COUNT-UP ═══ */
function animateCounters(){
  document.querySelectorAll('[data-count]').forEach(el=>{
    const target=parseInt(el.dataset.count,10);
    const prefix=el.dataset.prefix||'';
    const suffix=el.dataset.suffix||'';
    const start=performance.now();
    const dur=1200;
    function step(now){
      const t=Math.min(1,(now-start)/dur);
      const e=1-Math.pow(1-t,3); /* ease-out cubic */
      const v=Math.round(target*e);
      el.textContent=prefix+v.toLocaleString()+suffix;
      if(t<1)requestAnimationFrame(step);
    }
    requestAnimationFrame(step);
  });
  /* Hero counters */
  countTo('hero-ytd',16300000,1500,v=>'R'+(v/1000000).toFixed(1)+'M');
  countTo('hero-avg',350000,1500,v=>'R'+(v/1000).toFixed(0)+'k');
  countTo('hero-cities',12,1500,v=>v);
}
function countTo(id,target,dur,fmt){
  const el=document.getElementById(id);
  if(!el)return;
  const deltaSpan=el.querySelector('.delta');
  const start=performance.now();
  function step(now){
    const t=Math.min(1,(now-start)/dur);
    const e=1-Math.pow(1-t,3);
    const v=Math.round(target*e);
    el.firstChild.nodeValue=fmt(v);
    if(deltaSpan)el.appendChild(deltaSpan);
    if(t<1)requestAnimationFrame(step);
  }
  requestAnimationFrame(step);
}

/* ═══════════════════════════════════════════════════ ARTIST SWITCHER ═══ */
function buildArtistMenu(){
  document.getElementById('artist-menu').innerHTML=ARTISTS.map(a=>`
    <div class="artist-menu-item ${a.id===curArtist?'active':''}" onclick="switchArtist('${a.id}')">
      <div class="avatar ${a.cls}" style="width:24px;height:24px;font-size:10px">${a.av}</div>
      ${a.name}
    </div>`).join('');
}
let menuOpen=false;
function toggleArtistMenu(){
  menuOpen=!menuOpen;
  document.getElementById('artist-menu').classList.toggle('open',menuOpen);
  document.getElementById('artist-pill').classList.toggle('open',menuOpen);
}
function switchArtist(id){
  curArtist=id;
  const a=ARTISTS.find(x=>x.id===id);
  const av=document.getElementById('cur-avatar');
  av.textContent=a.av;
  av.className='avatar '+a.cls;
  document.getElementById('cur-name').textContent=a.name;
  document.getElementById('cur-genre').textContent=a.genre;
  buildArtistMenu();
  toggleArtistMenu();
  showToast(`Switched workspace → ${a.name}`);
}

/* ═══════════════════════════════════════════════════ SIDEBAR (mobile) ═══ */
function openSidebar(){document.getElementById('sidebar').classList.add('open');document.getElementById('scrim').classList.add('show')}
function closeSidebar(){document.getElementById('sidebar').classList.remove('open');document.getElementById('scrim').classList.remove('show')}

/* ═══════════════════════════════════════════════════ NAV / VIEWS ═══ */
function navTo(id,navEl){
  document.querySelectorAll('.view').forEach(v=>v.classList.remove('active'));
  const tgt=document.getElementById('view-'+id);
  tgt.classList.add('active');
  document.querySelectorAll('.nav-item').forEach(n=>n.classList.remove('active'));
  if(navEl)navEl.classList.add('active');
  document.querySelector('.main').scrollTop=0;
  closeSidebar();
  if(id==='gigs')renderGigsTable();
  if(id==='calendar')renderCalendar();
  if(id==='map')renderMap();
  if(id==='revenue')renderRevenue();
  if(id==='contracts')renderContracts();
  if(id==='rider')renderRider();
  if(id==='team')renderTeam();
  if(id==='compare')renderCompare();
}

/* ═══════════════════════════════════════════════════ DASHBOARD ═══ */
function renderDashboard(){
  /* Pipeline */
  const cols=[
    {key:'inquiry',label:'Inquiry',color:'#1A73E8'},
    {key:'hold',label:'On hold',color:'#F9AB00'},
    {key:'confirmed',label:'Confirmed',color:'#34A853'},
    {key:'completed',label:'Completed',color:'#5F6368'},
  ];
  let totalSum=0;
  document.getElementById('pipelineBoard').innerHTML=cols.map(col=>{
    let list;
    if(col.key==='completed') list=GIGS.filter(g=>new Date(g.date)<new Date('2025-04-26'));
    else list=GIGS.filter(g=>g.status===col.key && new Date(g.date)>=new Date('2025-04-26'));
    const sum=list.reduce((s,g)=>s+g.fee,0);
    if(col.key!=='completed')totalSum+=sum;
    return `<div class="kanban-col">
      <div class="kanban-head">
        <div class="kanban-dot" style="background:${col.color}"></div>
        <div class="kanban-name">${col.label}</div>
        <div class="kanban-count">${list.length}</div>
      </div>
      <div class="kanban-sum">R${Math.round(sum/1000)}k ${col.key==='completed'?'earned':col.key==='confirmed'?'locked':'potential'}</div>
      <div class="kanban-list">
        ${list.length?list.map(g=>renderGigCard(g,col.color)).join(''):'<div class="kanban-empty">No bookings</div>'}
      </div>
    </div>`;
  }).join('');
  document.getElementById('pipelineSum').textContent=`R${Math.round(totalSum/1000)}k pipeline · ${GIGS.length} bookings tracked`;

  /* Upcoming list */
  const up=GIGS.filter(g=>g.status==='confirmed' && new Date(g.date)>=new Date('2025-04-26')).slice(0,5);
  document.getElementById('upcomingList').innerHTML=up.map(g=>`
    <div class="feed-item" onclick="openDetail(${g.id})">
      <div class="feed-icon blue">${g.flag}</div>
      <div class="feed-body">
        <div class="feed-text"><b>${escapeHtml(g.name)}</b> · ${escapeHtml(g.city)}</div>
        <div class="feed-time">${fmtDate(g.date).toUpperCase()} · ${fmtMoney(g.fee,g.cur)}</div>
      </div>
    </div>`).join('');

  /* Activity */
  document.getElementById('activityFeed').innerHTML=ACTIVITY.map(a=>`
    <div class="feed-item">
      <div class="feed-icon ${a.icon}">${a.sym}</div>
      <div class="feed-body">
        <div class="feed-text">${a.text}</div>
        <div class="feed-time">${a.time}</div>
      </div>
    </div>`).join('');

  /* Notif badge count */
  document.getElementById('nav-gigs-count').textContent=GIGS.filter(g=>new Date(g.date)>=new Date('2025-04-26')).length;
}

function renderGigCard(g,accent){
  const tagCls={Club:'club',Festival:'fest',Event:'event'}[g.type]||'club';
  return `<div class="gig-card ${g.urgent?'urgent':''}" onclick="openDetail(${g.id})">
    <div class="gig-row">
      <div>
        <div class="gig-name">${g.flag} ${escapeHtml(g.name)}</div>
        <div class="gig-city">${escapeHtml(g.city)}</div>
      </div>
      <div class="gig-tag ${tagCls}">${g.type}</div>
    </div>
    <div class="gig-foot">
      <div class="gig-date">${fmtDateShort(g.date)}</div>
      <div class="gig-fee" style="color:${accent}">${fmtMoney(g.fee,g.cur)}</div>
    </div>
  </div>`;
}

/* ═══════════════════════════════════════════════════ REVENUE CHART (SVG) ═══ */
function renderRevenueChart(range='12M'){
  const rev={
    '12M':{labels:['May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr'],series1:[42,68,95,62,55,48,38,52,68,82,95,105],series2:[58,75,108,72,62,55,45,62,78,92,108,120],series3:[35,55,82,52,45,38,30,42,55,72,82,95]},
    '6M':{labels:['Nov','Dec','Jan','Feb','Mar','Apr'],series1:[38,52,68,82,95,105],series2:[45,62,78,92,108,120],series3:[30,42,55,72,82,95]},
    '3M':{labels:['Feb','Mar','Apr'],series1:[82,95,105],series2:[92,108,120],series3:[72,82,95]},
    'YTD':{labels:['Jan','Feb','Mar','Apr'],series1:[68,82,95,105],series2:[78,92,108,120],series3:[55,72,82,95]},
  };
  const d=rev[range];
  const w=820,h=240,padL=44,padR=16,padT=16,padB=32;
  const innerW=w-padL-padR, innerH=h-padT-padB;
  const max=Math.max(...d.series2)*1.1;
  const xStep=innerW/(d.labels.length-1);
  const yScale=v=>padT+innerH-(v/max)*innerH;
  const xPos=i=>padL+i*xStep;

  function line(series,color,opacity=1,dashed=false,width=2){
    const pts=series.map((v,i)=>`${xPos(i)},${yScale(v)}`).join(' ');
    return `<polyline points="${pts}" fill="none" stroke="${color}" stroke-width="${width}" stroke-linecap="round" stroke-linejoin="round" opacity="${opacity}" ${dashed?'stroke-dasharray="4 4"':''}/>`;
  }
  function area(series,color){
    const pts=series.map((v,i)=>`${xPos(i)},${yScale(v)}`).join(' ');
    return `<polygon points="${padL},${padT+innerH} ${pts} ${padL+innerW},${padT+innerH}" fill="${color}" opacity="0.08"/>`;
  }
  /* y grid */
  let grid='';
  for(let i=0;i<=4;i++){
    const y=padT+(innerH/4)*i;
    const v=Math.round(max*(1-i/4));
    grid+=`<line x1="${padL}" y1="${y}" x2="${padL+innerW}" y2="${y}" stroke="#EBEDEF" stroke-width="1"/>`;
    grid+=`<text x="${padL-8}" y="${y+4}" font-size="10" fill="#80868B" text-anchor="end" font-family="Roboto Mono">R${v}k</text>`;
  }
  /* x labels */
  let xLabels='';
  d.labels.forEach((l,i)=>{
    xLabels+=`<text x="${xPos(i)}" y="${h-12}" font-size="10" fill="#80868B" text-anchor="middle" font-family="Roboto Mono">${l}</text>`;
  });
  /* Dots on series1 */
  let dots='';
  d.series1.forEach((v,i)=>{
    dots+=`<circle cx="${xPos(i)}" cy="${yScale(v)}" r="3" fill="#fff" stroke="#1A73E8" stroke-width="2"/>`;
  });
  /* Last point pulsing */
  const li=d.series1.length-1;
  dots+=`<circle cx="${xPos(li)}" cy="${yScale(d.series1[li])}" r="6" fill="#1A73E8" opacity="0.18"><animate attributeName="r" values="6;10;6" dur="2s" repeatCount="indefinite"/></circle>`;
  dots+=`<circle cx="${xPos(li)}" cy="${yScale(d.series1[li])}" r="4" fill="#1A73E8" stroke="#fff" stroke-width="2"/>`;

  document.getElementById('chartSvgWrap').innerHTML=`
    <svg viewBox="0 0 ${w} ${h}" width="100%" height="${h}" preserveAspectRatio="xMidYMid meet" style="display:block">
      ${grid}
      ${area(d.series2,'#C9A961')}
      ${line(d.series2,'#C9A961',0.7,true,1.8)}
      ${area(d.series1,'#1A73E8')}
      ${line(d.series1,'#1A73E8',1,false,2.4)}
      ${line(d.series3,'#34A853',0.85,false,2)}
      ${dots}
      ${xLabels}
    </svg>`;
}
function setChartRange(r,btn){
  document.querySelectorAll('.sec-tab').forEach(b=>b.classList.remove('active'));
  btn.classList.add('active');
  renderRevenueChart(r);
}

/* ═══════════════════════════════════════════════════ GIGS TABLE ═══ */
function renderGigsTable(){
  const filt=document.getElementById('gigFilter')?.value||'all';
  const search=document.getElementById('searchInput')?.value.toLowerCase()||'';
  let rows=filt==='all'?GIGS:GIGS.filter(g=>g.status===filt);
  if(search)rows=rows.filter(g=>g.name.toLowerCase().includes(search)||g.city.toLowerCase().includes(search)||g.promoter.toLowerCase().includes(search));
  document.getElementById('gigsSubText').innerHTML=`<b>${rows.length}</b> bookings · 2025 season`;
  document.getElementById('gigsTable').innerHTML=`
    <thead><tr><th>Event</th><th>Date</th><th>City</th><th>Status</th><th>Fee</th><th>Contract</th><th>Deposit</th></tr></thead>
    <tbody>${rows.length?rows.map(g=>`<tr onclick="openDetail(${g.id})">
      <td><div class="strong">${g.flag} ${escapeHtml(g.name)}</div><div style="color:var(--muted);font-size:11px;margin-top:2px;font-family:'Roboto Mono'">${escapeHtml(g.promoter)}</div></td>
      <td class="mono" style="color:var(--muted)">${fmtDate(g.date)}</td>
      <td style="color:var(--ink-2)">${escapeHtml(g.city)}</td>
      <td>${badgeStatus(g.status)}</td>
      <td class="mono strong" style="color:var(--gold-h)">${fmtMoney(g.fee,g.cur)}</td>
      <td>${badgeContract(g.contract)}</td>
      <td>${depositCell(g.deposit)}</td>
    </tr>`).join(''):'<tr><td colspan="7" style="text-align:center;padding:32px;color:var(--muted);font-style:italic">No bookings match.</td></tr>'}</tbody>`;
}

/* ═══════════════════════════════════════════════════ CALENDAR ═══ */
let cY=2025,cM=4;
const MONTHS=['January','February','March','April','May','June','July','August','September','October','November','December'];
const DOWS=['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
function renderCalendar(){
  document.getElementById('calMonth').innerHTML=`${MONTHS[cM]}<span class="yr">${cY}</span>`;
  const dayMap={};
  GIGS.forEach(g=>{const d=new Date(g.date+'T12:00:00');if(d.getFullYear()===cY&&d.getMonth()===cM){
    if(!dayMap[d.getDate()])dayMap[d.getDate()]=[];
    dayMap[d.getDate()].push(g);
  }});
  const fd=new Date(cY,cM,1).getDay();
  const td=new Date(cY,cM+1,0).getDate();
  const today=new Date();
  let h=DOWS.map(d=>`<div class="cal-dow">${d}</div>`).join('');
  for(let i=0;i<fd;i++)h+='<div class="cal-day empty"></div>';
  for(let d=1;d<=td;d++){
    const items=dayMap[d]||[];
    const isToday=cY===today.getFullYear()&&cM===today.getMonth()&&d===today.getDate();
    const pellets=items.slice(0,3).map(g=>`<div class="cal-pellet ${g.status}"></div>`).join('');
    h+=`<div class="cal-day ${items.length?'has':''} ${isToday?'today':''}" onclick="calPick(${d})">${d}<div class="cal-pellets">${pellets}</div></div>`;
  }
  document.getElementById('calGrid').innerHTML=h;
}
function calShift(n){cM+=n;if(cM>11){cM=0;cY++}if(cM<0){cM=11;cY--}renderCalendar();document.getElementById('calDetail').className='cal-detail empty';document.getElementById('calDetail').textContent='Tap a date to see scheduled bookings'}
function calToday(){const d=new Date();cY=d.getFullYear();cM=d.getMonth();renderCalendar()}
function calPick(d){
  const items=GIGS.filter(g=>{const dt=new Date(g.date+'T12:00:00');return dt.getFullYear()===cY&&dt.getMonth()===cM&&dt.getDate()===d});
  const el=document.getElementById('calDetail');
  if(!items.length){el.className='cal-detail empty';el.textContent=`${MONTHS[cM]} ${d} — no bookings scheduled`;return}
  el.className='cal-detail';
  el.innerHTML=`<div style="font-family:'Google Sans';font-size:14px;font-weight:500;color:var(--ink);margin-bottom:10px">${MONTHS[cM]} ${d}, ${cY}</div>`+items.map(g=>`
    <div class="feed-item" style="padding:10px 0;border-bottom:1px solid var(--border-soft);cursor:pointer" onclick="openDetail(${g.id})">
      <div class="feed-icon blue">${g.flag}</div>
      <div class="feed-body">
        <div class="feed-text"><b>${escapeHtml(g.name)}</b></div>
        <div class="feed-time">${escapeHtml(g.city)} · ${fmtMoney(g.fee,g.cur)} · ${badgeStatus(g.status)}</div>
      </div>
    </div>`).join('');
}

/* ═══════════════════════════════════════════════════ TOUR MAP (Google Maps) ═══ */

/* ═══════════════════════════════════════════════════ AUTH SYSTEM (Supabase) ═══ */
const ROLE_PERMS = {
  manager:{
    allow:['All bookings & pipeline','Revenue & financials','Contracts & invoices','Rider builder (edit)','Team & permissions','All artists'],
    deny:[]
  },
  artist:{
    allow:['Your confirmed bookings','Your calendar','Your rider (view)','Your profile'],
    deny:['Financial details hidden','Cannot edit bookings','Cannot view other artists']
  }
};
let currentUser = null;       // { id, email, full_name, role, av, cls }
let selectedRole = 'manager'; // login-screen toggle (manager | artist)
let authMode     = 'signin';  // 'signin' | 'signup'

function selectRole(role){
  selectedRole = role;
  document.querySelectorAll('.role-btn').forEach(b=>b.classList.remove('selected'));
  const el = document.getElementById('role-'+role);
  if(el) el.classList.add('selected');
  const perms = ROLE_PERMS[role];
  const permPanel = document.getElementById('login-perms');
  if(!permPanel) return;
  permPanel.style.display = 'block';
  document.getElementById('login-perms-list').innerHTML = [
    ...perms.allow.map(p=>`<div class="perm-item allow">${p}</div>`),
    ...perms.deny.map(p=>`<div class="perm-item deny">${p}</div>`)
  ].join('');
}

function toggleAuthMode(){
  authMode = (authMode === 'signin') ? 'signup' : 'signin';
  const btn   = document.querySelector('.login-btn');
  const toggle= document.getElementById('login-toggle');
  const sub   = document.querySelector('.login-sub');
  const nameField = document.getElementById('login-name-field');
  if(authMode === 'signup'){
    btn.textContent = 'Create account →';
    toggle.innerHTML = 'Already have an account? <a href="#" onclick="event.preventDefault();toggleAuthMode()">Sign in</a>';
    if(sub) sub.textContent = 'Welcome to SetFlow. Press Play.';
    if(nameField) nameField.style.display = 'block';
  } else {
    btn.textContent = 'Press Play →';
    toggle.innerHTML = "Don't have an account? <a href=\"#\" onclick=\"event.preventDefault();toggleAuthMode()\">Create one</a>";
    if(sub) sub.textContent = 'Your stage is set. Press Play.';
    if(nameField) nameField.style.display = 'none';
  }
  document.getElementById('login-err').textContent = '';
}

async function doLogin(){
  if(authMode === 'signup') return doSignup();

  const email = document.getElementById('login-email').value.trim().toLowerCase();
  const pass  = document.getElementById('login-pass').value;
  const errEl = document.getElementById('login-err');
  const btn   = document.querySelector('.login-btn');

  if(!email || !pass){ errEl.textContent = 'Email and password required.'; return; }

  btn.disabled = true; btn.textContent = 'Signing in…';
  errEl.textContent = '';

  const { data, error } = await sb.auth.signInWithPassword({ email, password: pass });

  btn.disabled = false; btn.textContent = 'Press Play →';

  if(error){
    errEl.textContent = error.message || 'Sign-in failed.';
    return;
  }
  await onAuthSuccess(data.session);
}

async function doSignup(){
  const email    = document.getElementById('login-email').value.trim().toLowerCase();
  const pass     = document.getElementById('login-pass').value;
  const fullName = (document.getElementById('login-name')||{}).value || '';
  const errEl    = document.getElementById('login-err');
  const btn      = document.querySelector('.login-btn');

  if(!email || !pass){ errEl.textContent = 'Email and password required.'; return; }
  if(pass.length < 6){ errEl.textContent = 'Password must be at least 6 characters.'; return; }

  btn.disabled = true; btn.textContent = 'Creating account…';
  errEl.textContent = '';

  const { data, error } = await sb.auth.signUp({
    email,
    password: pass,
    options: {
      data: {
        full_name: fullName || email.split('@')[0],
        role: selectedRole || 'manager',
        artist_name: fullName || 'My Artist'
      }
    }
  });

  if(error){
    btn.disabled = false; btn.textContent = 'Create account →';
    errEl.textContent = error.message || 'Sign-up failed.';
    return;
  }

  // If email confirmation is OFF, signUp returns a session and we're in.
  // If it's ON, session is null and we ask the user to check their inbox.
  if(data.session){
    await onAuthSuccess(data.session);
  } else {
    btn.disabled = false; btn.textContent = 'Create account →';
    errEl.style.color = '#5BB974';
    errEl.textContent = 'Check your inbox to confirm, then sign in.';
    authMode = 'signin'; toggleAuthMode();
  }
}

async function signOut(){
  await sb.auth.signOut();
  // Bounce back to the marketing landing page
  window.location.href = '/';
}

async function onAuthSuccess(session){
  // Fetch profile (created automatically by the handle_new_user trigger)
  const { data: profile } = await sb.from('profiles').select('*').eq('id', session.user.id).single();
  currentUser = {
    id:        session.user.id,
    email:     session.user.email,
    name:      profile?.full_name || session.user.email.split('@')[0],
    role:      profile?.role || selectedRole || 'manager',
    av:        profile?.avatar_initials || 'SF',
    cls:       profile?.avatar_class || 'bc'
  };

  // Pull data from DB into local caches
  await loadArtistsFromDb();
  await loadGigsFromDb();

  applyPermissions(currentUser.role);

  const ls = document.getElementById('loginScreen');
  if(ls){
    ls.style.opacity = '0';
    ls.style.transform = 'scale(1.04)';
    setTimeout(()=>{ ls.style.display = 'none'; runPreloader(); }, 420);
  } else {
    runPreloader();
  }
}

/* ── Restore an existing session on page load ── */
async function restoreSession(){
  const { data } = await sb.auth.getSession();
  if(data.session){
    await onAuthSuccess(data.session);
    return true;
  }
  return false;
}

/* ═══════════════════════════════════════════════════ DATA LAYER (Supabase) ═══ */
// Maps a DB row → in-memory shape used by render functions.
function rowToGig(r){
  return {
    id:        r.id,
    name:      r.name,
    city:      r.city || '',
    flag:      r.country_flag || '',
    address:   r.address || '',
    date:      r.gig_date || '',
    status:    r.status,
    fee:       Number(r.fee) || 0,
    cur:       r.currency || 'ZAR',
    deposit:   !!r.deposit_received,
    contract:  r.contract,
    type:      r.kind,
    promoter:  r.promoter || '',
    lat:       Number(r.lat) || 0,
    lng:       Number(r.lng) || 0,
    notes:     r.notes || '',
    urgent:    !!r.urgent,
    artist_id: r.artist_id
  };
}
function gigToRow(g){
  return {
    name:             g.name,
    city:             g.city || '',
    country_flag:     g.flag || '',
    address:          g.address || '',
    gig_date:         g.date || null,
    status:           g.status || 'inquiry',
    kind:             g.type || 'Club',
    fee:              Number(g.fee) || 0,
    currency:         (g.cur || 'ZAR').toUpperCase(),
    deposit_received: !!g.deposit,
    contract:         g.contract || 'none',
    promoter:         g.promoter || '',
    lat:              Number(g.lat) || 0,
    lng:              Number(g.lng) || 0,
    notes:            g.notes || '',
    urgent:           !!g.urgent
  };
}

async function loadArtistsFromDb(){
  const { data, error } = await sb.from('artists').select('*').order('created_at',{ascending:true});
  if(error){ console.warn('artists load error:', error); return; }
  if(data && data.length){
    ARTISTS = data.map(a => ({
      id:    a.id,
      name:  a.name,
      genre: a.genre || '',
      av:    a.avatar_initials || (a.name||'').slice(0,2).toUpperCase(),
      cls:   a.avatar_class || 'bc'
    }));
    curArtist = ARTISTS[0]?.id || null;
  } else {
    ARTISTS = [];
    curArtist = null;
  }
}

/* Helper to ensure user is authenticated before DB action */
async function getAuthenticatedUser() {
  const { data: { user }, error } = await sb.auth.getUser();
  if (error || !user) {
    console.error("User not logged in");
    // Optionally trigger your login UI here
    return null;
  }
  return user;
}

async function loadGigsFromDb() {
  // Optional: check auth first
  const { data, error } = await sb.from('gigs')
    .select('*')
    .order('gig_date', { ascending: true });
    
  if (error) { console.warn('gigs load error:', error); return; }
  GIGS = (data || []).map(rowToGig);
}

async function dbInsertGig(g) {
  const user = await getAuthenticatedUser();
  if (!user) throw new Error("Must be logged in to insert a gig");

  const row = gigToRow(g);
  row.owner_id  = user.id; // Use the verified user ID
  row.artist_id = curArtist;
  
  const { data, error } = await sb.from('gigs').insert(row).select().single();
  if (error) { console.error('gig insert error:', error); throw error; }
  return rowToGig(data);
}

function applyPermissions(role){
  // Update sidebar footer
  document.querySelector('.user-name').textContent = currentUser.name;
  document.querySelector('.user-role').textContent = role==='manager'?'Artist Manager · All Artists':'Artist Account';
  document.querySelector('.sidebar-foot .avatar').textContent = currentUser.av;
  document.querySelector('.sidebar-foot .avatar').className = 'avatar '+currentUser.cls;
  document.querySelector('.topbar .avatar').textContent = currentUser.av;
  document.querySelector('.topbar .avatar').className = 'avatar '+currentUser.cls+' ';
  document.querySelector('.topbar .avatar').style.cssText = 'width:36px;height:36px;font-size:11px;cursor:pointer';
  // Hide nav items for artist role
  if(role === 'artist'){
    document.querySelectorAll('[data-view="revenue"],[data-view="contracts"],[data-view="team"],[data-view="compare"]')
      .forEach(el=>el.style.display='none');
    document.querySelector('.plan-pill').textContent = 'ARTIST';
  }
  // Lock rider editing for artists
  if(role === 'artist') window.riderReadOnly = true;
  else window.riderReadOnly = false;
}

/* ═══════════════════════════════════════════════════ RIDER BUILDER (FULL CRUD) ═══ */
let RIDER = [
  {title:'Sound system',items:[
    {l:'L-Acoustics K2 or equivalent line array',d:true},
    {l:'Pioneer CDJ-3000 (×4) + DJM-A9 / V10',d:true},
    {l:'2× full-range stage monitors',d:false},
    {l:'English-speaking sound engineer on site',d:true},
  ]},
  {title:'Stage & DJ booth',items:[
    {l:'Enclosed booth, not fully exposed',d:true},
    {l:'Separate booth lighting from main rig',d:false},
    {l:'Min 4m × 3m performance area',d:true},
    {l:'Raised platform min 0.5m',d:true},
  ]},
  {title:'Hospitality',items:[
    {l:'2× non-smoking dressing rooms with locks',d:true},
    {l:'Hot meal (vegetarian option) for 4 persons',d:false},
    {l:'Premium spirits + full mixer selection',d:true},
    {l:'Still & sparkling water, 6 litres',d:true},
  ]},
  {title:'Travel & logistics',items:[
    {l:'Business class flights for 4 persons',d:true},
    {l:'5-star hotel, 2 nights minimum',d:true},
    {l:'Private airport transfer both directions',d:false},
    {l:'On-ground liaison contact',d:true},
  ]},
];

function renderRider(){
  const ro = window.riderReadOnly;
  document.getElementById('riderGrid').innerHTML = RIDER.map((s,si)=>`
    <div class="rider-section" id="rsec-${si}">
      <div class="rider-section-head">
        <div class="rider-section-head-edit" style="flex:1">
          ${ro
            ? `<div class="rider-section-title">${escapeHtml(s.title)}</div>`
            : `<input class="rider-section-name-input" value="${escapeHtml(s.title)}" onchange="riderRenameSection(${si},this.value)" title="Click to rename section"/>`
          }
        </div>
        <div style="display:flex;align-items:center;gap:8px">
          <div class="rider-section-meta">${s.items.filter(i=>i.d).length}/${s.items.length} confirmed</div>
          ${ro ? '' : `<button class="rider-add-btn" onclick="riderAddItem(${si})">+ Add item</button>`}
          ${ro ? '' : `<button class="rider-del-section" onclick="riderDeleteSection(${si})" title="Delete section">✕</button>`}
        </div>
      </div>
      <div class="rider-list" id="rlist-${si}">
        ${s.items.map((it,ii)=>riderItemHTML(si,ii,it,ro)).join('')}
      </div>
    </div>`).join('') +
    (ro ? '' : `<button class="rider-add-section-btn" onclick="riderAddSection()">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
      Add new section
    </button>`);
}

function riderItemHTML(si,ii,it,ro){
  return `<div class="rider-row ${it.d?'checked':''}" id="rrow-${si}-${ii}">
    <div class="rider-check" onclick="riderToggle(${si},${ii})">${it.d?'✓':''}</div>
    ${ro
      ? `<div class="rider-text">${escapeHtml(it.l)}</div>`
      : `<input class="rider-edit-input rider-text" value="${escapeHtml(it.l)}" onchange="riderEditItem(${si},${ii},this.value)" placeholder="Rider item…"/>`
    }
    ${ro ? '' : `<button class="rider-del" onclick="riderDeleteItem(${si},${ii})" title="Delete">✕</button>`}
  </div>`;
}

function riderToggle(si,ii){
  RIDER[si].items[ii].d = !RIDER[si].items[ii].d;
  renderRider();
  showToast(RIDER[si].items[ii].d ? 'Item confirmed ✓' : 'Item unchecked');
}

function riderAddItem(si){
  RIDER[si].items.push({l:'New rider item',d:false});
  renderRider();
  // Focus the new input
  const rows = document.querySelectorAll(`#rlist-${si} .rider-edit-input`);
  const last = rows[rows.length-1];
  if(last){ last.focus(); last.select(); }
}

function riderEditItem(si,ii,val){
  RIDER[si].items[ii].l = val;
}

function riderDeleteItem(si,ii){
  RIDER[si].items.splice(ii,1);
  renderRider();
  showToast('Item removed');
}

function riderRenameSection(si,val){
  RIDER[si].title = val;
}

function riderDeleteSection(si){
  if(!confirm(`Delete section "${RIDER[si].title}"?`)) return;
  RIDER.splice(si,1);
  renderRider();
  showToast('Section deleted');
}

function riderAddSection(){
  RIDER.push({title:'New section',items:[{l:'Add your first requirement',d:false}]});
  renderRider();
  // Focus section name
  const inputs = document.querySelectorAll('.rider-section-name-input');
  const last = inputs[inputs.length-1];
  if(last){ last.focus(); last.select(); }
}

/* ═══════════════════════════════════════════════════ MAP (Leaflet) ═══ */
let leafletMap = null;

function renderMap(){
  const confirmed = GIGS.filter(g=>g.status==='confirmed' && g.lat && g.lat!==0);
  const all = GIGS.filter(g=>g.lat && g.lat!==0);

  // Load Leaflet if not already
  if(!window.L){
    const link = document.createElement('link');
    link.rel = 'stylesheet';
    link.href = 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.min.css';
    document.head.appendChild(link);
    const script = document.createElement('script');
    script.src = 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.min.js';
    script.onload = ()=>buildLeafletMap(confirmed, all);
    document.head.appendChild(script);
  } else {
    buildLeafletMap(confirmed, all);
  }
}

function buildLeafletMap(confirmed, all){
  document.getElementById('map-loading').style.display = 'none';
  const mapEl = document.getElementById('worldMap');
  mapEl.innerHTML = '<div id="leaflet-map" style="width:100%;height:480px;border-radius:12px;overflow:hidden;border:1px solid var(--border-soft)"></div>';

  if(leafletMap){ leafletMap.remove(); leafletMap=null; }
  leafletMap = L.map('leaflet-map',{zoomControl:true,attributionControl:true});
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',{attribution:'© OpenStreetMap contributors',maxZoom:18}).addTo(leafletMap);

  const statusColors = {confirmed:'#34A853',hold:'#F9AB00',inquiry:'#1A73E8',completed:'#5F6368'};
  all.forEach(g=>{
    const color = statusColors[g.status]||'#5F6368';
    const marker = L.circleMarker([g.lat,g.lng],{radius:10,fillColor:color,color:'#fff',weight:2,opacity:1,fillOpacity:0.9}).addTo(leafletMap);
    marker.bindPopup(`<div style="font-family:Google Sans,sans-serif;min-width:180px">
      <div style="font-size:14px;font-weight:600">${g.flag} ${escapeHtml(g.name)}</div>
      <div style="font-size:11px;color:#666;margin:2px 0">${escapeHtml(g.city)} · ${fmtDate(g.date)}</div>
      <div style="font-size:11px;color:#666;margin:2px 0 6px">${escapeHtml(g.address||'')}</div>
      <div style="display:flex;justify-content:space-between;align-items:center">
        <span style="font-size:12px;background:${color}22;color:${color};padding:2px 8px;border-radius:100px;font-weight:500">${g.status}</span>
        <span style="font-size:13px;font-weight:600;color:#C9A961">${fmtMoney(g.fee,g.cur)}</span>
      </div>
    </div>`);
  });

  if(all.length>0){
    const bounds = L.latLngBounds(all.map(g=>[g.lat,g.lng]));
    leafletMap.fitBounds(bounds,{padding:[40,40]});
  }

  // Country stats
  const counts = {};
  confirmed.forEach(g=>{ counts[g.flag]=(counts[g.flag]||0)+1; });
  document.getElementById('mapStats').innerHTML = Object.entries(counts).map(([f,c])=>{
    const sum = confirmed.filter(g=>g.flag===f).reduce((s,g)=>s+g.fee,0);
    return `<div class="map-stat">
      <span class="map-stat-flag">${f}</span>
      <div class="map-stat-name">${c} gig${c>1?'s':''}</div>
      <div class="map-stat-data">≈ R${Math.round(sum*18.35/1000)}k</div>
    </div>`;
  }).join('');
}

/* ═══════════════════════════════════════════════════ TEAM ═══ */
function renderTeam(){
  document.getElementById('teamTable').innerHTML=`
    <thead><tr><th>Member</th><th>Role</th><th>Permissions</th><th>Email</th><th></th></tr></thead>
    <tbody>${TEAM.map(t=>`<tr>
      <td><div style="display:flex;align-items:center;gap:10px"><div class="avatar ${t.cls}" style="width:30px;height:30px;font-size:11px">${t.av}</div><div class="strong">${escapeHtml(t.name)}</div></div></td>
      <td><span class="badge b-inquiry">${escapeHtml(t.role)}</span></td>
      <td style="color:var(--ink-2)">${escapeHtml(t.perms)}</td>
      <td class="mono" style="color:var(--muted);font-size:12px">${escapeHtml(t.email)}</td>
      <td><button class="btn ghost sm">Edit</button></td>
    </tr>`).join('')}</tbody>`;
}

/* ═══════════════════════════════════════════════════ COMPARE ═══ */
/* ═══════════════════════════════════════════════════ BILLING TOGGLE ═══ */
let billingMode = 'monthly';
const PRICES = {
  foundations: { monthly: 'R950',    annual: 'R792' },
  pro:         { monthly: 'R4 500',  annual: 'R3 750' },
  agency:      { monthly: 'R10 500', annual: 'R8 750' },
};
function setBilling(mode){
  billingMode = mode;
  const suffix = mode === 'annual'
    ? '<span class="cmp-card-suffix">/ mo · billed annually</span>'
    : '<span class="cmp-card-suffix">/ mo</span>';
  Object.keys(PRICES).forEach(t => {
    const el = document.getElementById('price-' + t);
    if(el) el.innerHTML = PRICES[t][mode] + suffix;
  });
  /* Banner */
  const banner = document.getElementById('annual-banner');
  if(banner) banner.style.display = mode === 'annual' ? 'flex' : 'none';
  /* Toggle button styles */
  const mBtn = document.getElementById('bill-monthly');
  const aBtn = document.getElementById('bill-annual');
  if(mBtn) { mBtn.style.background = mode==='monthly' ? 'var(--ink)' : 'transparent'; mBtn.style.color = mode==='monthly' ? '#fff' : 'var(--ink-2)'; mBtn.style.fontWeight = mode==='monthly' ? '600' : '500'; }
  if(aBtn) { aBtn.style.background = mode==='annual'  ? 'var(--ink)' : 'transparent'; aBtn.style.color = mode==='annual'  ? '#fff' : 'var(--ink-2)'; aBtn.style.fontWeight = mode==='annual'  ? '600' : '500'; }
}

/* ═══════════════════════════════════════════════════ COMPARE ═══ */
function renderCompare(){
  const ic = v => v===true ? '<span class="cmp-y">●</span>' : v===false ? '<span class="cmp-n">○</span>' : '<span class="cmp-p">◐</span>';
  document.getElementById('cmpBody').innerHTML = COMP.map(f => `<tr>
    <td>${escapeHtml(f.f)}</td>
    <td>${ic(f.fo)}</td>
    <td class="sf">${ic(f.pr)}</td>
    <td class="sf">${ic(f.ag)}</td>
    <td class="sf">${ic(f.en)}</td>
    <td>${ic(f.gw)}</td>
    <td>${ic(f.xl)}</td>
  </tr>`).join('');
}

/* ═══════════════════════════════════════════════════ MODALS ═══ */
function openModal(id){document.getElementById('modal-'+id).classList.add('open')}
function closeModal(id){document.getElementById('modal-'+id).classList.remove('open')}
function overlayClose(e,id){if(e.target.id==='modal-'+id)closeModal(id)}

function openDetail(id){
  const g=GIGS.find(x=>x.id===id);
  if(!g)return;
  document.getElementById('d-title').innerHTML=`${g.flag} ${escapeHtml(g.name)}`;
  document.getElementById('d-sub').textContent=`${g.city} · ${fmtDate(g.date)}`;
  document.getElementById('d-status').innerHTML=badgeStatus(g.status);
  document.getElementById('d-fee').textContent=fmtMoney(g.fee,g.cur);
  document.getElementById('d-type').textContent=g.type;
  document.getElementById('d-prom').textContent=g.promoter;
  document.getElementById('d-contract').innerHTML=badgeContract(g.contract);
  document.getElementById('d-dep').innerHTML=depositCell(g.deposit);
  openModal('detail');
}

async function saveGig(){
  const name=document.getElementById('f-name').value.trim();
  if(!name){showToast('Venue name required');return}
  if(!currentUser){showToast('Not signed in');return}

  const draft = {
    name,
    city:document.getElementById('f-city').value||'TBC',
    flag:document.getElementById('f-country').value,
    date:document.getElementById('f-date').value||null,
    status:document.getElementById('f-status').value,
    fee:parseInt(document.getElementById('f-fee').value)||0,
    cur:document.getElementById('f-cur').value,
    type:document.getElementById('f-type').value,
    promoter:document.getElementById('f-promoter').value||'TBC',
    deposit:false, contract:'none', urgent:false,
    lat:0,lng:0,
  };

  const btn = document.querySelector('#modal-add .btn.primary');
  const orig = btn ? btn.textContent : '';
  if(btn){ btn.disabled = true; btn.textContent = 'Saving…'; }

  try {
    const saved = await dbInsertGig(draft);
    GIGS.unshift(saved);
    closeModal('add');
    ['f-name','f-city','f-fee','f-promoter','f-date'].forEach(i=>document.getElementById(i).value='');
    showToast(`Booking added — ${name}`);
    renderDashboard();
    if(document.getElementById('view-gigs').classList.contains('active')) renderGigsTable();
  } catch(err){
    showToast('Save failed — ' + (err.message || 'try again'));
  } finally {
    if(btn){ btn.disabled = false; btn.textContent = orig; }
  }
}

/* ═══════════════════════════════════════════════════ NOTIFICATIONS ═══ */
function toggleNotifs(){
  document.getElementById('notifPanel').classList.toggle('open');
}
function buildNotifs(){
  const tones={red:'red',gold:'gold',blue:'blue',green:'green'};
  document.getElementById('notifList').innerHTML=NOTIFS.map(n=>`
    <div class="feed-item">
      <div class="feed-icon ${tones[n.tone]}">${n.icon}</div>
      <div class="feed-body">
        <div class="feed-text"><b>${escapeHtml(n.title)}</b></div>
        <div class="feed-time" style="margin-top:2px;color:var(--muted);font-family:Roboto;font-size:12px;letter-spacing:0">${escapeHtml(n.body)}</div>
        <div class="feed-time">${escapeHtml(n.time)} ago</div>
      </div>
    </div>`).join('');
}
function markAllRead(){
  document.querySelector('.icon-btn .dot').style.display='none';
  showToast('All notifications marked read');
  toggleNotifs();
}

/* ═══════════════════════════════════════════════════ SEARCH ═══ */
function onSearch(){
  if(document.getElementById('view-gigs').classList.contains('active'))renderGigsTable();
}

/* ═══════════════════════════════════════════════════ EXPORT ═══ */
function exportData(){showToast('Export started — emailing CSV to you')}

/* ═══════════════════════════════════════════════════ INIT ═══ */
function init(){
  /* Dynamic time-of-day greeting */
  const hr = new Date().getHours();
  const greet = hr < 12 ? 'GOOD MORNING ✦' : hr < 17 ? 'GOOD AFTERNOON ✦' : 'GOOD EVENING ✦';
  const el = document.getElementById('hero-greeting');
  if(el) el.textContent = greet;

  buildArtistMenu();
  renderDashboard();
  renderRevenueChart('12M');
  buildNotifs();
  /* Click outside artist menu to close */
  document.addEventListener('click',e=>{
    const pill=document.getElementById('artist-pill');
    const menu=document.getElementById('artist-menu');
    if(!pill.contains(e.target)&&!menu.contains(e.target)&&menuOpen){toggleArtistMenu()}
    const np=document.getElementById('notifPanel');
    if(!np.contains(e.target)&&!e.target.closest('.icon-btn')&&np.classList.contains('open'))np.classList.remove('open');
  });
  /* Keyboard shortcut for search */
  document.addEventListener('keydown',e=>{
    if((e.ctrlKey||e.metaKey)&&e.key==='k'){e.preventDefault();document.getElementById('searchInput').focus()}
    if(e.key==='Escape'){
      ['add','detail'].forEach(closeModal);
      const np=document.getElementById('notifPanel');
      if(np.classList.contains('open'))np.classList.remove('open');
    }
  });
  /* Animated counters after a brief delay */
  setTimeout(animateCounters,180);
}
/* ═══════════════════════════════════════════════════ PRELOADER ═══ */
function runPreloader(){
  const preGigs = GIGS.filter(g=>g.status==='confirmed').slice(0,4);
  const statuses = [
    'Initialising workspace…',
    'Syncing booking pipeline…',
    'Loading tour map…',
    'Calibrating multi-currency…',
    'Ready — Press Play 🇿🇦'
  ];
  const bar = document.getElementById('preload-bar');
  const statusEl = document.getElementById('preload-status');
  const gigsEl = document.getElementById('preload-gigs');

  /* Reveal gig cards one by one */
  preGigs.forEach((g, i) => {
    setTimeout(() => {
      const div = document.createElement('div');
      div.style.cssText = `
        display:flex;align-items:center;gap:12px;padding:9px 12px;
        background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.10);
        border-radius:10px;animation:preGigIn 0.35s ease forwards;opacity:0;
      `;
      div.innerHTML = `
        <span style="font-size:18px">${g.flag}</span>
        <div style="flex:1;min-width:0">
          <div style="font-size:12px;font-weight:500;color:#fff;white-space:nowrap;overflow:hidden;text-overflow:ellipsis">${escapeHtml(g.name)}</div>
          <div style="font-size:10px;color:rgba(255,255,255,0.45);font-family:'Roboto Mono',monospace;margin-top:2px">${fmtDate(g.date)}</div>
        </div>
        <div style="font-size:12px;font-weight:600;color:#FFB612;font-family:'Roboto Mono',monospace;white-space:nowrap">${fmtMoney(g.fee,g.cur)}</div>
      `;
      gigsEl.appendChild(div);
    }, i * 280);
  });

  /* Progress bar + status steps */
  statuses.forEach((s, i) => {
    setTimeout(() => {
      bar.style.width = ((i + 1) / statuses.length * 100) + '%';
      statusEl.textContent = s;
      if(i === statuses.length - 1){
        /* Dismiss preloader */
        setTimeout(() => {
          const preloader = document.getElementById('preloader');
          preloader.style.opacity = '0';
          preloader.style.transform = 'scale(1.03)';
          setTimeout(() => { preloader.style.display = 'none'; }, 580);
          
          // Now proceed to init or check session
          initializeApp();
        }, 600);
      }
    }, i * 360 + 200);
  });
}

// ═══════════════════════════════════════════════════ APP BOOT ═══
// /app/ is auth-gated. If no session → bounce to / (marketing page).
// If session exists → skip login screen, fetch profile, run preloader, init app.
document.addEventListener("DOMContentLoaded", async () => {
  // Hide the legacy login screen — auth happens on the marketing page now.
  const loginScreen = document.getElementById('loginScreen');
  if(loginScreen) loginScreen.style.display = 'none';

  const { data: { session } } = await sb.auth.getSession();

  if(!session){
    // Not logged in — go back to marketing page where login modal lives.
    window.location.href = '/';
    return;
  }

  // We have a session. Run the standard auth-success flow which fetches
  // the profile, loads gigs from DB, applies permissions, and starts the preloader.
  try {
    await onAuthSuccess(session);
  } catch(e) {
    console.error('Auth bootstrap failed:', e);
    // If anything in the auth-success chain explodes, kick the user back home
    // so they can sign in again rather than getting stuck on a half-loaded app.
    await sb.auth.signOut();
    window.location.href = '/';
  }
});
</script>
</body>
</html>
