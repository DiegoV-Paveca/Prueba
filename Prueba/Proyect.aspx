<%@ Page Title="Proyección" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Proyect.aspx.cs" Inherits="Prueba.Proyect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

  <!-- Cargar ECharts solo si NO está en la Master -->
  <script src="https://cdn.jsdelivr.net/npm/echarts@5/dist/echarts.min.js"></script>

  <main class="container py-4 page-proyect"><!-- scope CSS local -->
    
    <!-- Encabezado de la vista -->
    <header class="pv-header row g-3 align-items-center mb-3">
      <div class="col-lg-7">
        <h1 class="pv-title m-0">Ventas 2024</h1>
        <p class="pv-subtitle m-0">Seguimiento mensual • Toneladas</p>
      </div>
      <div class="col-lg-5 text-lg-end">
  <div class="d-inline-flex flex-wrap align-items-center gap-2 pv-toolbar">
    <button type="button" class="btn btn-outline-secondary btn-sm btn-bounce" id="btnRefresh">
      <i class="bi bi-arrow-repeat"></i> Actualizar
    </button>
    <button type="button" class="btn btn-success btn-sm btn-bounce" id="btnDownload">
      <i class="bi bi-download"></i> Descargar PNG
    </button>
  </div>
</div>
    </header>

    <!-- Tarjetas KPI compactas -->
    <section class="row g-3 mb-3">
      <div class="col-6 col-md-3">
        <div class="pv-kpi">
          <span class="pv-kpi-label">Total año</span>
          <span class="pv-kpi-value" id="kpiTotal">—</span>
        </div>
      </div>
      <div class="col-6 col-md-3">
        <div class="pv-kpi">
          <span class="pv-kpi-label">Promedio mensual</span>
          <span class="pv-kpi-value" id="kpiProm">—</span>
        </div>
      </div>
      <div class="col-6 col-md-3">
        <div class="pv-kpi">
          <span class="pv-kpi-label">Máximo</span>
          <span class="pv-kpi-value" id="kpiMax">—</span>
        </div>
      </div>
      <div class="col-6 col-md-3">
        <div class="pv-kpi">
          <span class="pv-kpi-label">Mínimo</span>
          <span class="pv-kpi-value" id="kpiMin">—</span>
        </div>
      </div>
    </section>

    <!-- Tarjeta contenedora del gráfico -->
    <section class="pv-card">
      <div class="pv-card-header">
        <div class="d-flex align-items-center justify-content-between">
          <div class="d-flex align-items-center gap-2">
            <i class="bi bi-graph-up-arrow text-success"></i>
            <strong>Producción PAVECA (Enero–Diciembre)</strong>
          </div>
          <div class="d-none d-md-flex align-items-center gap-2 pv-legend-hint">
            <span class="pv-dot" style="--dot:#157347"></span> Venezuela
          </div>
        </div>
      </div>

      <!-- 🔹 El gráfico NO se toca (mismo id, tamaño y estructura) -->
      <div class="pv-card-body">
        <div id="chartProduccion" style="width:100%;height:360px;"></div>
      </div>

      <div class="pv-card-footer d-flex flex-wrap gap-2">
        <small class="text-muted">Fuente: Datos internos</small>
      </div>
    </section>

  </main>

  <script>
      document.addEventListener('DOMContentLoaded', initProduccionMultiLinea);

      function initProduccionMultiLinea() {
          const chartDom = document.getElementById('chartProduccion');
          const chart = echarts.init(chartDom);

          const meses = [
              'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
              'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
          ];

          // 👉 Reemplaza con tus valores reales (ahora calculamos KPIs con esto)
          const Venezuela = Array.from({ length: 12 }, () => Math.floor(Math.random() * 51) + 48);

          const option = {
              title: { show: false }, // (lo movimos a la tarjeta)
              tooltip: { trigger: 'axis' },
              legend: { show: false }, // (mostramos hint arriba)
              toolbox: {
                  feature: {
                      dataView: { readOnly: true, title: 'Ver datos' },
                  }
              },
              grid: { left: 40, right: 20, top: 10, bottom: 40 }, // menos aire arriba (la tarjeta ya tiene header)
              xAxis: { type: 'category', data: meses },
              yAxis: {
                  type: 'value',
                  name: 'Toneladas',
                  nameGap: 14,
                  splitLine: { lineStyle: { type: 'dashed' } }
              },
              series: [
                  {
                      name: 'Venezuela',
                      type: 'line',
                      smooth: true,
                      showSymbol: false,
                      data: Venezuela,
                      lineStyle: { color: '#157347', width: 3 },   // verde PAVECA oscuro
                      areaStyle: { color: 'rgba(21,115,71,0.10)' } // relleno suave
                  },
              ]
          };

          chart.setOption(option);
          window.addEventListener('resize', () => chart.resize());

          // ---------- KPIs (solo UI) ----------
          const sum = Venezuela.reduce((a, b) => a + b, 0);
          const avg = (sum / Venezuela.length) || 0;
          const max = Math.max.apply(null, Venezuela);
          const min = Math.min.apply(null, Venezuela);
          setText('kpiTotal', formatNumber(sum));
          setText('kpiProm', formatNumber(avg));
          setText('kpiMax', formatNumber(max));
          setText('kpiMin', formatNumber(min));

          function setText(id, v) { var el = document.getElementById(id); if (el) el.textContent = v; }
          function formatNumber(n) { return new Intl.NumberFormat('es-VE', { maximumFractionDigits: 0 }).format(n); }

          // Botones de la toolbar
          const btnRefresh = document.getElementById('btnRefresh');
          const btnDownload = document.getElementById('btnDownload');

          if (btnRefresh) {
              btnRefresh.addEventListener('click', () => {
                  chart.resize(); // simple “refresh”
              });
          }

          if (btnDownload) {
              btnDownload.addEventListener('click', () => {
                  // 1) Obtiene el dataURL del gráfico en PNG
                  const dataURL = chart.getDataURL({
                      type: 'png',         // 'png' o 'jpeg'
                      pixelRatio: 2,       // más nitidez en pantallas retina
                      backgroundColor: '#ffffff' // fondo blanco (opcional)
                  });

                  // 2) Crea un enlace temporal y dispara la descarga
                  const link = document.createElement('a');
                  link.href = dataURL;
                  link.download = 'produccion_paveca.png'; // nombre del archivo
                  document.body.appendChild(link);
                  link.click();
                  document.body.removeChild(link);
              });
          }

      }
  </script>

    <script>
        document.addEventListener('DOMContentLoaded', initProduccionMultiLinea);

        function initProduccionMultiLinea() {
            const chartDom = document.getElementById('chartProduccion');
            const chart = echarts.init(chartDom);

            // === Estado (único origen de verdad) ===
            const state = {
                meses: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                series: {
                    Venezuela: [] // se llena al refrescar
                }
            };

            // === Init de chart con option base ===
            const option = {
                title: { show: false },
                tooltip: { trigger: 'axis' },
                legend: { show: false },
                toolbox: {
                    feature: {
                        dataView: { readOnly: true, title: 'Ver datos' },
                        saveAsImage: { title: 'Descargar PNG' }
                    }
                },
                grid: { left: 40, right: 20, top: 10, bottom: 40 },
                xAxis: { type: 'category', data: state.meses },
                yAxis: {
                    type: 'value',
                    name: 'Toneladas',
                    nameGap: 14,
                    splitLine: { lineStyle: { type: 'dashed' } }
                },
                series: [
                    {
                        name: 'Venezuela',
                        type: 'line',
                        smooth: true,
                        showSymbol: false,
                        data: [], // se llena en refreshAll
                        lineStyle: { color: '#157347', width: 3 },
                        areaStyle: { color: 'rgba(21,115,71,0.10)' }
                    }
                ]
            };
            chart.setOption(option);

            // === Funciones utilitarias ===
            function formatNumber(n) {
                if (n === '' || n === null || typeof n === 'undefined') return '';
                return new Intl.NumberFormat('es-VE', { maximumFractionDigits: 2 }).format(n);
            }
            function escapeHtml(str) {
                return String(str).replace(/[&<>"']/g, s => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[s]));
            }
            function setText(id, v) {
                const el = document.getElementById(id);
                if (el) el.textContent = v;
            }
            function modalIsOpen() {
                const el = document.getElementById('dataViewModal');
                // Bootstrap 5: si tiene 'show' en la clase, está visible
                return el && el.classList.contains('show');
            }

            // === Render de KPIs ===
            function renderKpis() {
                const vals = state.series.Venezuela || [];
                const sum = vals.reduce((a, b) => a + b, 0);
                const avg = vals.length ? sum / vals.length : 0;
                const max = vals.length ? Math.max.apply(null, vals) : 0;
                const min = vals.length ? Math.min.apply(null, vals) : 0;

                setText('kpiTotal', formatNumber(sum));
                setText('kpiProm', formatNumber(avg));
                setText('kpiMax', formatNumber(max));
                setText('kpiMin', formatNumber(min));
            }

            // === Render de tabla (modal Ver datos) ===
            function renderTable() {
                const thead = document.querySelector('#dataViewTable thead');
                const tbody = document.querySelector('#dataViewTable tbody');
                if (!thead || !tbody) return;

                // Cabecera
                let ths = '<tr><th style="min-width:140px">Mes</th><th>Venezuela</th></tr>';
                thead.innerHTML = ths;

                // Filas
                let rows = '';
                state.meses.forEach((mes, i) => {
                    const v = state.series.Venezuela[i] ?? '';
                    rows += `<tr><td>${escapeHtml(mes)}</td><td>${formatNumber(v)}</td></tr>`;
                });
                tbody.innerHTML = rows;
            }

            // === Refrescar datos + chart + KPIs + tabla ===
            function refreshAll() {
                // a) Obtener / regenerar datos (reemplaza esto por tu fetch AJAX si aplica)
                state.series.Venezuela = Array.from({ length: 12 }, () => Math.floor(Math.random() * 51) + 48);

                // b) Actualizar chart
                chart.setOption({
                    series: [{ name: 'Venezuela', data: state.series.Venezuela }]
                });

                // c) Actualizar KPIs
                renderKpis();

                // d) Si el modal está abierto (o si existe la tabla), re-render de tabla
                //    Si quieres SIEMPRE reconstruir la tabla aunque el modal esté cerrado, quita el if.
                if (document.getElementById('dataViewTable')) {
                    renderTable();
                }
            }

            // === Botón: Ver datos => abre modal y renderiza la tabla con datos actuales ===
            const btnData = document.getElementById('btnData');
            if (btnData) {
                btnData.addEventListener('click', () => {
                    renderTable();
                    const modalEl = document.getElementById('dataViewModal');
                    if (modalEl && typeof bootstrap !== 'undefined') {
                        const modal = new bootstrap.Modal(modalEl);
                        modal.show();
                    } else {
                        // Bootstrap 4 con jQuery:
                        // $('#dataViewModal').modal('show');
                    }
                });
            }

            // === Botón: Descargar PNG ===
            const btnDownload = document.getElementById('btnDownload');
            if (btnDownload) {
                btnDownload.addEventListener('click', () => {
                    const dataURL = chart.getDataURL({
                        type: 'png',
                        pixelRatio: 2,
                        backgroundColor: '#ffffff'
                    });
                    const link = document.createElement('a');
                    link.href = dataURL;
                    link.download = 'produccion_paveca.png';
                    document.body.appendChild(link);
                    link.click();
                    document.body.removeChild(link);
                });
            }

            // === Botón: Actualizar (refresca todo, incluyendo tabla) ===
            const btnRefresh = document.getElementById('btnRefresh');
            if (btnRefresh) {
                btnRefresh.addEventListener('click', refreshAll);
            }

            // Primera carga
            refreshAll();

            // Resizar
            window.addEventListener('resize', () => chart.resize());
        }
    </script>
</asp:Content>