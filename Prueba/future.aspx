<%@ Page Title="Futuro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Prueba.future" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Fondo (Canvas) -->
    <div id="futuristic-bg" class="bg-holder">
        <canvas id="net-canvas"></canvas>
    </div>

    <!-- Contenido principal (encima del canvas) -->
    <div class="container content-overlay">
        <h1 class="display-4 fw-bold text-white mb-3">El Futuro de PAVECA</h1>
        <p class="lead text-white-50 mb-5">
            Innovación, tecnología y redes de distribución interconectadas en constante movimiento.
        </p>

        <div class="row g-4">
            <div class="col-md-6">
                <div class="glass-card">
                    <h3>Red de Distribución</h3>
                    <p>
                        Nuestros nodos logísticos se conectan entre si para optimizar las entregas a nivel nacional,
                        adaptándose dinámicamente a la demanda.
                    </p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="glass-card">
                    <h3>Análisis de Datos</h3>
                    <p>
                        Procesamos miles de variables simultáneas para garantizar la calidad en cada bobina de papel,
                        utilizando algoritmos de vanguardia.
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- ====== Estilos mínimos (puedes moverlos a Site.css) ====== -->
    <style>
        /* El canvas cubre toda la pantalla por detrás del contenido */
        #futuristic-bg.bg-holder {
            position: fixed; /* o absolute si prefieres que no siga el scroll */
            inset: 0;
            z-index: 0;           /* detrás del contenido */
            pointer-events: none; /* no bloquea clicks */
            background: transparent;
        }

        .content-overlay {
            position: relative;
            z-index: 1;
        }

        /* Tarjetas con efecto vidrio (opcional) */
        .glass-card {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            padding: 1.25rem;
            color: #fff;
            backdrop-filter: blur(8px);
        }

        /* Si el usuario pide menos animación, la desactivamos */
        @media (prefers-reduced-motion: reduce) {
            #futuristic-bg { display: none !important; }
        }
    </style>

    <!-- ====== Script Canvas 2D de alto rendimiento ====== -->
    <script>
        (function () {
            // Configuración general (puedes ajustar valores)
            const BASE_NODE_COUNT = 70;     // cantidad de puntos
            const MAX_DIST = 150;           // distancia máxima para conectar puntos
            const SPEED = 0.60;             // velocidad base
            const FPS = 30;                 // límite de frames por segundo
            const COLOR_POINT = 'rgba(255,255,255,0.85)';
            const COLOR_LINE_BASE = 'rgba(255,255,255,'; // se completa con opacidad ")"

            // Ajustes por dispositivo
            const isMobile = window.matchMedia('(pointer: coarse)').matches;
            const prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

            // Bajamos carga en móviles
            const NODE_COUNT = isMobile ? Math.max(30, Math.round(BASE_NODE_COUNT * 0.6)) : BASE_NODE_COUNT;
            const EFFECT_MAX_DIST = isMobile ? Math.round(MAX_DIST * 0.8) : MAX_DIST;
            const EFFECT_SPEED = isMobile ? SPEED * 0.7 : SPEED;

            document.addEventListener('DOMContentLoaded', init, { once: true });

            function init() {
                // Si el usuario pidió menos animación, desactiva
                if (prefersReduced) return;

                document.body.classList.add('page-futuro');

                const holder = document.getElementById('futuristic-bg');
                const canvas = document.getElementById('net-canvas');
                if (!holder || !canvas) return;

                const ctx = canvas.getContext('2d', { alpha: true });

                // Limita DPR para no disparar píxeles en 4K; 1.5 suele dar buen balance
                let dpr = Math.min(window.devicePixelRatio || 1, 1.5);
                let w = 0, h = 0;

                function resize() {
                    w = window.innerWidth;
                    h = window.innerHeight;
                    canvas.style.width = w + 'px';
                    canvas.style.height = h + 'px';
                    canvas.width = Math.floor(w * dpr);
                    canvas.height = Math.floor(h * dpr);
                    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
                }

                // Nodos
                const POINT_MIN = 2.2, POINT_MAX = 4.5;
                const nodes = new Array(NODE_COUNT).fill(0).map((_, i) => ({
                    id: i,
                    x: Math.random() * window.innerWidth,
                    y: Math.random() * window.innerHeight,
                    r: POINT_MIN + Math.random() * (POINT_MAX - POINT_MIN),
                    vx: (Math.random() - 0.5) * EFFECT_SPEED * 2,
                    vy: (Math.random() - 0.5) * EFFECT_SPEED * 2
                }));

                // Rejilla espacial
                const CELL = EFFECT_MAX_DIST; // tamaño de celda ≈ distancia de conexión
                function buildGrid() {
                    const grid = new Map(); // key: "cx,cy" -> array de índices
                    for (let i = 0; i < nodes.length; i++) {
                        const n = nodes[i];
                        const cx = (n.x / CELL) | 0;
                        const cy = (n.y / CELL) | 0;
                        const key = cx + ',' + cy;
                        let bucket = grid.get(key);
                        if (!bucket) { bucket = []; grid.set(key, bucket); }
                        bucket.push(i);
                    }
                    return grid;
                }

                // Animación con requestAnimationFrame + límite de FPS
                let running = true, animId = null, last = 0, interval = 1000 / FPS;

                function step(ts) {
                    if (!running) { animId = requestAnimationFrame(step); return; }
                    if (ts - last < interval) { animId = requestAnimationFrame(step); return; }
                    last = ts;

                    // Actualización de posiciones
                    for (let i = 0; i < nodes.length; i++) {
                        const n = nodes[i];
                        n.x += n.vx; n.y += n.vy;
                        if (n.x < 0 || n.x > w) n.vx *= -1;
                        if (n.y < 0 || n.y > h) n.vy *= -1;
                    }

                    // Construye rejilla y pinta
                    const grid = buildGrid();
                    const max2 = EFFECT_MAX_DIST * EFFECT_MAX_DIST;

                    ctx.clearRect(0, 0, w, h);

                    // Líneas primero (puntos encima)
                    ctx.lineWidth = 1;
                    for (let i = 0; i < nodes.length; i++) {
                        const a = nodes[i];
                        const cx = (a.x / CELL) | 0;
                        const cy = (a.y / CELL) | 0;

                        // Celda propia + 8 vecinas
                        for (let ox = -1; ox <= 1; ox++) {
                            for (let oy = -1; oy <= 1; oy++) {
                                const key = (cx + ox) + ',' + (cy + oy);
                                const bucket = grid.get(key);
                                if (!bucket) continue;

                                for (let k = 0; k < bucket.length; k++) {
                                    const j = bucket[k];
                                    if (j <= i) continue; // evita duplicados
                                    const b = nodes[j];

                                    const dx = a.x - b.x, dy = a.y - b.y;
                                    const d2 = dx * dx + dy * dy;
                                    if (d2 < max2) {
                                        const d = Math.sqrt(d2);
                                        const op = (1 - d / EFFECT_MAX_DIST) * 0.6; // opacidad
                                        ctx.strokeStyle = COLOR_LINE_BASE + op + ')';
                                        ctx.beginPath();
                                        ctx.moveTo(a.x, a.y);
                                        ctx.lineTo(b.x, b.y);
                                        ctx.stroke();
                                    }
                                }
                            }
                        }
                    }

                    // Puntos
                    ctx.fillStyle = COLOR_POINT;
                    for (let i = 0; i < nodes.length; i++) {
                        const n = nodes[i];
                        ctx.beginPath();
                        ctx.arc(n.x, n.y, n.r, 0, Math.PI * 2);
                        ctx.fill();
                    }

                    animId = requestAnimationFrame(step);
                }

                // Resize (con debounce)
                let rzT;
                function onResize() {
                    clearTimeout(rzT);
                    rzT = setTimeout(() => {
                        dpr = Math.min(window.devicePixelRatio || 1, 1.5);
                        resize();
                    }, 120);
                }

                // Pausa por visibilidad de pestaña
                function onVisibility() {
                    running = !document.hidden;
                }

                // Pausa si el canvas no está en viewport
                let io = null;
                if ('IntersectionObserver' in window) {
                    io = new IntersectionObserver(([entry]) => {
                        running = entry.isIntersecting && !document.hidden;
                    });
                    io.observe(holder);
                }

                // Inicializa
                resize();
                animId = requestAnimationFrame(step);

                window.addEventListener('resize', onResize);
                document.addEventListener('visibilitychange', onVisibility);

                // Limpieza
                window.addEventListener('beforeunload', () => {
                    running = false;
                    cancelAnimationFrame(animId);
                    window.removeEventListener('resize', onResize);
                    document.removeEventListener('visibilitychange', onVisibility);
                    if (io) io.disconnect();
                    document.body.classList.remove('page-futuro');
                });
            }
        })();
    </script>

</asp:Content>