<%@ Page Title="Proyección" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Proyect.aspx.cs" Inherits="Prueba.Proyect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

  <!-- Cargar librerías -->
  <script src="https://cdn.jsdelivr.net/npm/echarts@5/dist/echarts.min.js" defer></script>
  <script src="https://cdn.jsdelivr.net/npm/jspdf@2.5.1/dist/jspdf.umd.min.js" defer></script>
  <script src="https://cdn.jsdelivr.net/npm/xlsx@0.18.5/dist/xlsx.full.min.js" defer></script>

  <!-- FONDO SUTIL MINIMALISTA (Patrón de puntos) -->
  <div class="proyect-bg-pattern"></div>

  <main class="container py-5 page-proyect">
    <div class="mx-auto pv-shell">

      <!-- HEADER MINIMALISTA Y BOTONES CLAROS -->
      <header class="pv-header row g-3 align-items-end mb-4">
        <div class="col-lg-5">
          <h1 class="pv-title m-0">Ventas 2024</h1>
          <p class="pv-subtitle m-0 mt-1">
              <span id="liveIndicator" class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 rounded-pill px-3">
                  <i class="bi bi-circle-fill small me-1" style="font-size: 0.6em;"></i> En vivo
              </span>
              &nbsp;• Seguimiento mensual (Toneladas)
          </p>
        </div>
        <div class="col-lg-7 text-lg-end">
          <div class="d-flex justify-content-lg-end">
          <div class="btn-group" role="group" aria-label="Export y acciones">
            <button type="button" class="btn btn-export btn-export-png btn-bounce shadow-sm" id="btnDownload" title="Descargar como Imagen PNG">
              <i class="bi bi-image"></i> Imagen
            </button>
            <button type="button" class="btn btn-export btn-export-pdf btn-bounce shadow-sm" id="btnPdf" title="Descargar como Documento PDF">
              <i class="bi bi-filetype-pdf"></i> PDF
            </button>
            <button type="button" class="btn btn-export btn-export-excel btn-bounce shadow-sm" id="btnExcel" title="Descargar como Hoja de Cálculo Excel">
              <i class="bi bi-file-earmark-spreadsheet"></i> Excel
            </button>
            <button type="button" class="btn btn-pv-primary btn-bounce shadow-sm" id="btnRefresh">
              <i class="bi bi-arrow-repeat"></i> Actualizar Ahora
            </button>
          </div>
        </div>
        </div>
      </header>

      <!-- KPIs (Tarjetas flotantes) -->
      <section class="row g-4 mb-4">
        <div class="col-6 col-md-3">
            <div class="pv-kpi">
                <div class="d-flex justify-content-between align-items-start">
                    <span class="pv-kpi-label">Total año</span>
                    <i class="bi bi-calendar3 text-muted opacity-50"></i>
                </div>
                <span class="pv-kpi-value" id="kpiTotal">—</span>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="pv-kpi">
                <div class="d-flex justify-content-between align-items-start">
                    <span class="pv-kpi-label">Promedio mensual</span>
                    <i class="bi bi-calculator text-muted opacity-50"></i>
                </div>
                <span class="pv-kpi-value" id="kpiProm">—</span>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="pv-kpi">
                <div class="d-flex justify-content-between align-items-start">
                    <span class="pv-kpi-label">Máximo</span>
                    <i class="bi bi-graph-up-arrow text-success opacity-75"></i>
                </div>
                <span class="pv-kpi-value" id="kpiMax">—</span>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="pv-kpi">
                <div class="d-flex justify-content-between align-items-start">
                    <span class="pv-kpi-label">Mínimo</span>
                    <i class="bi bi-graph-down-arrow text-danger opacity-75"></i>
                </div>
                <span class="pv-kpi-value" id="kpiMin">—</span>
            </div>
        </div>
      </section>

      <!-- TARJETA DEL GRÁFICO -->
      <section class="pv-card shadow-sm">
        <div class="pv-card-header">
          <div class="d-flex align-items-center justify-content-between">
            <div class="d-flex align-items-center gap-2">
              <div class="icon-box">
                  <i class="bi bi-bar-chart-fill"></i>
              </div>
              <strong style="color: var(--text-main);">Producción PAVECA (Base de Datos)</strong>
            </div>
            <div class="d-none d-md-flex align-items-center gap-2 pv-legend-hint">
              <span class="pv-dot" style="--dot:#007853"></span> Venezuela
            </div>
          </div>
        </div>

        <div class="pv-card-body">
          <div id="chartProduccion" class="pv-chart" role="img" aria-label="Gráfico de líneas de producción mensual"></div>
        </div>
      </section>

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
    [data-theme="dark"] .proyect-bg-pattern {
        background-image: radial-gradient(rgba(255, 255, 255, 0.04) 1px, transparent 1px);
    }

    /* ==========================================================================
       ESTILOS DE LA PÁGINA
       ========================================================================== */
    .pv-shell { max-width: 1100px; } 
    .pv-title { font-weight: 800; color: var(--text-main); letter-spacing: -0.5px; }
    .pv-subtitle { color: var(--text-muted); font-size: 0.95rem; display: flex; align-items: center; }

    /* Tarjetas KPI */
    .pv-kpi { 
        background: var(--bg-surface);
        border: 1px solid var(--border-color);
        border-radius: 12px;
        padding: 1.25rem;
        display: flex;
        flex-direction: column;
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05), 0 4px 6px -2px rgba(0, 0, 0, 0.025);
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .pv-kpi:hover {
        transform: translateY(-3px);
        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    }
    .pv-kpi-label { font-size: 0.85rem; color: var(--text-muted); font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 0.5rem; }
    .pv-kpi-value { font-size: 1.75rem; font-weight: 800; color: var(--text-main); }

    /* Tarjeta del Gráfico */
    .pv-card { 
        background: var(--bg-surface);
        border: 1px solid var(--border-color);
        border-radius: 16px;
        overflow: hidden; 
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
        transition: background-color 0.3s ease, border-color 0.3s ease;
    }
    .pv-card-header { 
        padding: 1.25rem 1.5rem;
        background: transparent;
        border-bottom: 1px solid var(--border-color); 
    }
    .pv-card-body { padding: 1rem 1.5rem 1.5rem 1.5rem; }
    
    .icon-box {
        background: rgba(0, 120, 83, 0.1);
        color: #007853;
        width: 32px; height: 32px;
        display: flex; align-items: center; justify-content: center;
        border-radius: 8px;
    }

    .pv-dot { width: 10px; height: 10px; border-radius: 50%; background: var(--dot,#007853); display: inline-block; }
    .pv-chart { width: 100%; height: 400px; } 

    /* Botones */
    .btn-export {
        background: var(--bg-surface);
        color: var(--text-main);
        border: 1px solid var(--border-color);
        font-weight: 600;
        font-size: 0.85rem;
        padding: 0.5rem 1.2rem;
        border-radius: 50rem;
        display: inline-flex;
        align-items: center;
        gap: 0.4rem;
        transition: all 0.3s ease;
    }
    .btn-export-png i:first-child { color: #0d6efd; }
    .btn-export-pdf i:first-child { color: #dc3545; }
    .btn-export-excel i:first-child { color: #198754; }
    .btn-export-png:hover { border-color: #0d6efd; background: rgba(13, 110, 253, 0.1); color: #0d6efd; }
    .btn-export-pdf:hover { border-color: #dc3545; background: rgba(220, 53, 69, 0.1); color: #dc3545; }
    .btn-export-excel:hover { border-color: #198754; background: rgba(25, 135, 84, 0.1); color: #198754; }

    .btn-pv-primary {
        background: #007853;
        color: white;
        border: 1px solid #006447;
        font-weight: 600;
        font-size: 0.9rem;
        padding: 0.5rem 1.2rem;
        border-radius: 8px;
        display: inline-flex;
        align-items: center;
        gap: 0.4rem;
    }
    .btn-pv-primary:hover { background: #006447; color: white; }
    .btn-bounce:active { transform: translateY(2px) scale(0.98); }
    
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

              if (!el.clientHeight) el.style.height = '400px';

              state.chart = echarts.init(el, null, { renderer: 'canvas' });

              state.chart.setOption({
                  animation: true,
                  tooltip: {
                      trigger: 'axis',
                      axisPointer: { type: 'line' },
                      backgroundColor: 'rgba(255, 255, 255, 0.9)',
                      borderColor: '#e6e9ee',
                      textStyle: { color: '#0f172a' }
                  },
                  legend: { show: false },
                  grid: { left: 45, right: 20, top: 20, bottom: 40 },
                  xAxis: {
                      type: 'category',
                      data: state.meses,
                      boundaryGap: false,
                      axisLine: { lineStyle: { color: '#adb5bd' } },
                      axisLabel: { color: '#6b7280' }
                  },
                  yAxis: {
                      type: 'value',
                      name: 'Toneladas',
                      nameTextStyle: { color: '#6b7280', padding: [0, 0, 0, 20] },
                      splitLine: { lineStyle: { type: 'dashed', color: '#e6e9ee' } },
                      axisLabel: { color: '#6b7280' },
                      min: (v) => Math.floor(v.min * 0.9)
                  },
                  series: [{
                      name: 'Venezuela',
                      type: 'line',
                      smooth: true,
                      showSymbol: false,
                      sampling: 'lttb',
                      lineStyle: { color: '#007853', width: 3 },
                      areaStyle: {
                          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                              { offset: 0, color: 'rgba(0, 120, 83, 0.3)' },
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

              window.addEventListener('themeChanged', function (e) {
                  var newTheme = e.detail;
                  var textColor = newTheme === 'dark' ? '#adb5bd' : '#6b7280';
                  var splitLineColor = newTheme === 'dark' ? '#333333' : '#e6e9ee';
                  var tooltipBg = newTheme === 'dark' ? 'rgba(30, 30, 30, 0.9)' : 'rgba(255, 255, 255, 0.9)';
                  var tooltipText = newTheme === 'dark' ? '#f8f9fa' : '#0f172a';

                  state.chart.setOption({
                      tooltip: { backgroundColor: tooltipBg, borderColor: splitLineColor, textStyle: { color: tooltipText } },
                      xAxis: { axisLine: { lineStyle: { color: textColor } }, axisLabel: { color: textColor } },
                      yAxis: { nameTextStyle: { color: textColor }, splitLine: { lineStyle: { color: splitLineColor } }, axisLabel: { color: textColor } }
                  });
              });
          }

          // =========================================================
          // FUNCIÓN: OBTENER DATOS DE LA BD
          // =========================================================
          function refreshAll(silent) {
              // Solo mostramos el spinner si NO es una actualización silenciosa (automática)
              if (!silent) {
                  state.chart.showLoading({
                      text: 'Cargando BD...',
                      color: '#007853',
                      textColor: '#007853',
                      maskColor: document.documentElement.getAttribute('data-theme') === 'dark' ? 'rgba(30, 30, 30, 0.8)' : 'rgba(255, 255, 255, 0.8)',
                      zlevel: 0
                  });
              }

              // Llamada AJAX al Backend (C#)
              fetch('Proyect.aspx/ObtenerDatosProduccion', {
                  method: 'POST',
                  headers: { 'Content-Type': 'application/json' },
                  body: '{}',
                  credentials: 'include' 
              })
                  .then(response => response.json())
                  .then(data => {
                      const datosBD = data.d; // ASP.NET devuelve los datos en ".d"

                      if (!datosBD || datosBD.length === 0) {
                          console.warn("BD vacía o error.");
                          state.datos = Array(12).fill(0);
                      } else {
                          // Comprobación simple: Si los datos son idénticos, no redibujamos (ahorra recursos)
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
                      if (!silent) {
                          state.chart.hideLoading();
                          // Opcional: alert('Error de conexión');
                      }
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
                  refreshAll(false); // Forzamos spinner al hacer clic manual
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