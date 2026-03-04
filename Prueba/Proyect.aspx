<%@ Page Title="Proyección" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Proyect.aspx.cs" Inherits="Prueba.Proyect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

  <!-- Cargar librerías -->
  <script src="https://cdn.jsdelivr.net/npm/echarts@5/dist/echarts.min.js" defer></script>
  <script src="https://cdn.jsdelivr.net/npm/jspdf@2.5.1/dist/jspdf.umd.min.js" defer></script>
  <script src="https://cdn.jsdelivr.net/npm/xlsx@0.18.5/dist/xlsx.full.min.js" defer></script>

  <!-- FONDO SUTIL MINIMALISTA (Patrón de puntos) -->
  <div class="proyect-bg-pattern"></div>

  <main class="container py-4">
    <!-- CONTENEDOR PRINCIPAL TIPO TARJETA (Diseño Unificado) -->
    <div class="bg-white mx-auto shadow-sm" style="max-width:1200px; border-radius:8px; border-top: 5px solid #007853; overflow: hidden;">
      
      <div class="p-4 p-lg-5">
        <!-- HEADER MINIMALISTA Y BOTONES CLAROS -->
        <header class="row g-3 align-items-end mb-5 border-bottom pb-4">
          <div class="col-lg-5">
            <h1 class="fw-bold text-dark m-0" style="letter-spacing: -0.5px;">Ventas 2024</h1>
            <p class="text-muted m-0 mt-2 d-flex align-items-center">
                <span id="liveIndicator" class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 rounded-pill px-3 py-2 fw-normal">
                    <i class="bi bi-circle-fill small me-1" style="font-size: 0.6em;"></i> En vivo
                </span>
                <span class="mx-2">•</span> Seguimiento mensual (Toneladas)
            </p>
          </div>
          <div class="col-lg-7 text-lg-end">
            <div class="d-flex justify-content-lg-end flex-wrap gap-2">
              <div class="btn-group shadow-sm rounded-pill overflow-hidden" role="group" aria-label="Export y acciones">
                <button type="button" class="btn btn-light border-end btn-export-png" id="btnDownload" title="Descargar como Imagen PNG">
                  <i class="bi bi-image text-primary"></i> <span class="d-none d-md-inline ms-1">Imagen</span>
                </button>
                <button type="button" class="btn btn-light border-end btn-export-pdf" id="btnPdf" title="Descargar como Documento PDF">
                  <i class="bi bi-filetype-pdf text-danger"></i> <span class="d-none d-md-inline ms-1">PDF</span>
                </button>
                <button type="button" class="btn btn-light btn-export-excel" id="btnExcel" title="Descargar como Hoja de Cálculo Excel">
                  <i class="bi bi-file-earmark-spreadsheet text-success"></i> <span class="d-none d-md-inline ms-1">Excel</span>
                </button>
              </div>
              
              <button type="button" class="btn btn-paveca shadow-sm rounded-pill px-4" id="btnRefresh">
                <i class="bi bi-arrow-repeat me-1"></i> Actualizar
              </button>
            </div>
          </div>
        </header>

        <!-- KPIs (Tarjetas flotantes) -->
        <section class="row g-4 mb-5">
          <div class="col-6 col-md-3">
              <div class="p-4 rounded-3 border bg-light h-100 position-relative overflow-hidden kpi-card">
                  <div class="d-flex justify-content-between align-items-start mb-3">
                      <span class="text-uppercase text-muted fw-bold small tracking-wide">Total año</span>
                      <div class="icon-circle bg-white text-muted shadow-sm">
                        <i class="bi bi-calendar3"></i>
                      </div>
                  </div>
                  <span class="display-6 fw-bold text-dark" id="kpiTotal">—</span>
              </div>
          </div>
          <div class="col-6 col-md-3">
              <div class="p-4 rounded-3 border bg-light h-100 position-relative overflow-hidden kpi-card">
                  <div class="d-flex justify-content-between align-items-start mb-3">
                      <span class="text-uppercase text-muted fw-bold small tracking-wide">Promedio</span>
                      <div class="icon-circle bg-white text-muted shadow-sm">
                        <i class="bi bi-calculator"></i>
                      </div>
                  </div>
                  <span class="display-6 fw-bold text-dark" id="kpiProm">—</span>
              </div>
          </div>
          <div class="col-6 col-md-3">
              <div class="p-4 rounded-3 border bg-light h-100 position-relative overflow-hidden kpi-card">
                  <div class="d-flex justify-content-between align-items-start mb-3">
                      <span class="text-uppercase text-muted fw-bold small tracking-wide">Máximo</span>
                      <div class="icon-circle bg-success bg-opacity-10 text-success shadow-sm">
                        <i class="bi bi-graph-up-arrow"></i>
                      </div>
                  </div>
                  <span class="display-6 fw-bold text-dark" id="kpiMax">—</span>
              </div>
          </div>
          <div class="col-6 col-md-3">
              <div class="p-4 rounded-3 border bg-light h-100 position-relative overflow-hidden kpi-card">
                  <div class="d-flex justify-content-between align-items-start mb-3">
                      <span class="text-uppercase text-muted fw-bold small tracking-wide">Mínimo</span>
                      <div class="icon-circle bg-danger bg-opacity-10 text-danger shadow-sm">
                        <i class="bi bi-graph-down-arrow"></i>
                      </div>
                  </div>
                  <span class="display-6 fw-bold text-dark" id="kpiMin">—</span>
              </div>
          </div>
        </section>

        <!-- TARJETA DEL GRÁFICO -->
        <section class="card border-0 shadow-none">
          <div class="card-header bg-transparent border-0 p-0 mb-3">
            <div class="d-flex align-items-center justify-content-between">
              <div class="d-flex align-items-center gap-3">
                <div class="icon-box-lg bg-paveca-light text-paveca rounded-3 d-flex align-items-center justify-content-center" style="width: 48px; height: 48px;">
                    <i class="bi bi-bar-chart-fill fs-4"></i>
                </div>
                <div>
                  <h5 class="fw-bold text-dark m-0">Producción PAVECA</h5>
                  <small class="text-muted">Datos en tiempo real desde la Base de Datos</small>
                </div>
              </div>
              <div class="d-none d-md-flex align-items-center gap-2 bg-light px-3 py-1 rounded-pill border">
                <span class="pv-dot" style="--dot:#007853"></span> <span class="small fw-bold text-muted">Venezuela</span>
              </div>
            </div>
          </div>

          <div class="card-body p-0">
            <div id="chartProduccion" class="w-100" style="height: 450px;" role="img" aria-label="Gráfico de líneas de producción mensual"></div>
          </div>
        </section> 
      </div>
      
      <!-- Footer interno pequeño -->
      <div class="text-center py-3 bg-light border-top mt-4">
          <small class="text-muted">© 2026 Papeles Venezolanos C.A. - Todos los derechos reservados.</small>
      </div>

    </div>       
  </main>

  <!-- ESTILOS CSS -->
  <style>
    /* ==========================================================================
       FONDO MINIMALISTA (Patrón de Puntos)
       ========================================================================== */
    .proyect-bg-pattern {
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        z-index: -1;
        pointer-events: none;
        background-image: radial-gradient(rgba(0, 120, 83, 0.08) 1px, transparent 1px);
        background-size: 24px 24px; 
    }
    
    /* Colores PAVECA */
    .text-paveca { color: #007853; }
    .bg-paveca-light { background-color: rgba(0, 120, 83, 0.1); }
    .btn-paveca { background-color: #007853; color: white; border: 1px solid #007853; transition: all 0.2s; }
    .btn-paveca:hover { background-color: #005f42; color: white; transform: translateY(-1px); }
    
    /* Utilidades */
    .tracking-wide { letter-spacing: 0.05em; }
    .icon-circle { width: 32px; height: 32px; border-radius: 50%; display: flex; align-items: center; justify-content: center; }
    .pv-dot { width: 10px; height: 10px; border-radius: 50%; background: var(--dot,#007853); display: inline-block; }

    /* KPI Cards Hover Effect */
    .kpi-card { transition: transform 0.2s ease, box-shadow 0.2s ease; }
    .kpi-card:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(0,0,0,0.05) !important; border-color: #007853 !important; }

    /* Animación de pulso para el indicador "En vivo" */
    @keyframes pulse-green {
        0% { box-shadow: 0 0 0 0 rgba(25, 135, 84, 0.4); }
        70% { box-shadow: 0 0 0 6px rgba(25, 135, 84, 0); }
        100% { box-shadow: 0 0 0 0 rgba(25, 135, 84, 0); }
    }
    #liveIndicator i { animation: pulse-green 2s infinite; border-radius: 50%; }
  </style>

  <!-- JS PRINCIPAL -->
  <script>
      (function () {
          'use strict';

          const state = {
              meses: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
              datos: [],
              stats: { sum: 0, avg: 0, max: 0, min: 0 },
              chart: null,
              intervalId: null
          };

          document.addEventListener('DOMContentLoaded', () => {
              if (window.echarts) init();
              else window.addEventListener('load', init, { once: true });
          });

          function init() {
              const el = document.getElementById('chartProduccion');
              if (!el) return;

              state.chart = echarts.init(el, null, { renderer: 'canvas' });

              state.chart.setOption({
                  animation: true,
                  tooltip: {
                      trigger: 'axis',
                      axisPointer: { type: 'line' },
                      backgroundColor: 'rgba(255, 255, 255, 0.95)',
                      borderColor: '#e6e9ee',
                      textStyle: { color: '#0f172a' },
                      padding: 12,
                      extraCssText: 'box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); border-radius: 8px;'
                  },
                  legend: { show: false },
                  grid: { left: 50, right: 30, top: 30, bottom: 40, containLabel: true },
                  xAxis: {
                      type: 'category',
                      data: state.meses,
                      boundaryGap: false,
                      axisLine: { lineStyle: { color: '#e2e8f0' } },
                      axisLabel: { color: '#64748b', fontWeight: 500, margin: 14 },
                      axisTick: { show: false }
                  },
                  yAxis: {
                      type: 'value',
                      splitLine: { lineStyle: { type: 'dashed', color: '#f1f5f9' } },
                      axisLabel: { color: '#64748b' },
                      min: (v) => Math.floor(v.min * 0.9)
                  },
                  series: [{
                      name: 'Venezuela',
                      type: 'line',
                      smooth: true,
                      showSymbol: false,
                      symbolSize: 8,
                      itemStyle: { color: '#007853', borderColor: '#fff', borderWidth: 2 },
                      lineStyle: { color: '#007853', width: 3, shadowColor: 'rgba(0, 120, 83, 0.2)', shadowBlur: 10 },
                      areaStyle: {
                          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                              { offset: 0, color: 'rgba(0, 120, 83, 0.15)' },
                              { offset: 1, color: 'rgba(0, 120, 83, 0.0)' }
                          ])
                      },
                      data: []
                  }]
              }, { notMerge: true, lazyUpdate: true });

              // 1. Carga inicial
              refreshAll(false);

              // 2. ACTIVAR ACTUALIZACIÓN AUTOMÁTICA (Cada 5 segundos)
              state.intervalId = setInterval(() => {
                  refreshAll(true); // true = modo silencioso (sin spinner)
              }, 5000);

              bindToolbar();

              // Limpieza al salir
              window.addEventListener('beforeunload', () => {
                  if (state.intervalId) clearInterval(state.intervalId);
              });

              if ('ResizeObserver' in window) {
                  const ro = new ResizeObserver(() => state.chart && state.chart.resize());
                  ro.observe(el);
              } else {
                  window.addEventListener('resize', () => state.chart && state.chart.resize());
              }
          }

          // =========================================================
          // FUNCIÓN: OBTENER DATOS DE LA BD
          // =========================================================
          function refreshAll(silent) {
              if (!silent) {
                  state.chart.showLoading({
                      text: 'Cargando BD...',
                      color: '#007853',
                      textColor: '#007853',
                      maskColor: 'rgba(255, 255, 255, 0.8)',
                      zlevel: 0
                  });
              }

              // Llamada AJAX al Backend (C#)
              fetch('Proyect.aspx/ObtenerDatosProduccion', {
                  method: 'POST',
                  headers: { 'Content-Type': 'application/json' },
                  body: '{}'
              })
                  .then(response => response.json())
                  .then(data => {
                      const datosBD = data.d;

                      if (!datosBD || datosBD.length === 0) {
                          console.warn("BD vacía o error.");
                          state.datos = Array(12).fill(0);
                      } else {
                          if (JSON.stringify(state.datos) === JSON.stringify(datosBD)) {
                              if (!silent) state.chart.hideLoading();
                              return;
                          }
                          state.datos = datosBD;
                      }

                      state.chart.setOption({ series: [{ data: state.datos }] });
                      updateKPIs(state.datos);

                      if (!silent) state.chart.hideLoading();
                  })
                  .catch(error => {
                      console.error('Error BD:', error);
                      if (!silent) state.chart.hideLoading();
                  });
          }

          function updateKPIs(arr) {
              const sum = arr.reduce((a, b) => a + b, 0);
              const avg = arr.length ? sum / arr.length : 0;
              const max = arr.length ? Math.max.apply(null, arr) : 0;
              const min = arr.length ? Math.min.apply(null, arr) : 0;
              state.stats = { sum, avg, max, min };

              const nf0 = new Intl.NumberFormat('es-VE', { maximumFractionDigits: 0 });
              setText('kpiTotal', nf0.format(sum));
              setText('kpiProm', nf0.format(avg));
              setText('kpiMax', nf0.format(max));
              setText('kpiMin', nf0.format(min));
          }

          function setText(id, v) { const n = document.getElementById(id); if (n) n.textContent = v; }

          function bindToolbar() {
              const btnRefresh = document.getElementById('btnRefresh');
              const btnDownload = document.getElementById('btnDownload');
              const btnPdf = document.getElementById('btnPdf');
              const btnExcel = document.getElementById('btnExcel');

              btnRefresh && btnRefresh.addEventListener('click', () => {
                  btnRefresh.blur();
                  refreshAll(false);
              });

              btnDownload && btnDownload.addEventListener('click', () => runWithGuard(btnDownload, () => {
                  const dataURL = state.chart.getDataURL({ type: 'png', pixelRatio: 2, backgroundColor: '#ffffff' });
                  const a = document.createElement('a'); a.href = dataURL; a.download = 'produccion_paveca.png';
                  document.body.appendChild(a); a.click(); a.remove();
              }));

              btnPdf && btnPdf.addEventListener('click', () => runWithGuard(btnPdf, () => {
                  const { jsPDF } = window.jspdf; const pdf = new jsPDF({ orientation: 'landscape', unit: 'mm', format: 'a4' });
                  const pageW = pdf.internal.pageSize.getWidth(), pageH = pdf.internal.pageSize.getHeight(), margin = 10;
                  pdf.setFont('helvetica', 'bold'); pdf.setFontSize(14); pdf.text('Producción PAVECA 2024', margin, 15);
                  pdf.setFont('helvetica', 'normal'); pdf.setFontSize(10); pdf.text('Enero – Diciembre (Toneladas)', margin, 21);
                  const img = state.chart.getDataURL({ type: 'png', pixelRatio: 2, backgroundColor: '#ffffff' });
                  const ratio = (state.chart.getDom().clientWidth || 16) / (state.chart.getDom().clientHeight || 9);
                  const maxW = pageW - margin * 2, maxH = pageH - margin * 2 - 15;
                  let w = maxW, h = w / ratio; if (h > maxH) { h = maxH; w = h * ratio; }
                  pdf.addImage(img, 'PNG', margin + (maxW - w) / 2, 27, w, h, undefined, 'FAST');
                  pdf.save('produccion_paveca.pdf');
              }));

              btnExcel && btnExcel.addEventListener('click', () => runWithGuard(btnExcel, () => {
                  const header = ['Mes', 'Venezuela (Toneladas)'];
                  const rows = state.meses.map((m, i) => [m, state.datos[i] ?? '']);
                  const resumen = [[], ['Total', state.stats.sum], ['Promedio', state.stats.avg], ['Máximo', state.stats.max], ['Mínimo', state.stats.min]];
                  const wb = XLSX.utils.book_new();
                  const ws = XLSX.utils.aoa_to_sheet([header, ...rows, ...resumen]);
                  ws['!cols'] = [{ wch: 16 }, { wch: 24 }];
                  XLSX.utils.book_append_sheet(wb, ws, 'Producción 2024');
                  XLSX.writeFile(wb, 'produccion_paveca.xlsx');
              }));
          }

          function runWithGuard(btn, fn) {
              if (!btn) return;
              btn.disabled = true; requestAnimationFrame(() => btn.blur());
              try { fn(); } finally { setTimeout(() => btn.disabled = false, 150); }
          }
      })();
  </script>

</asp:Content>