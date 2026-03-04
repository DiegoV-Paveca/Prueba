<%@ Page Title="Futuro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Future.aspx.cs" Inherits="Prueba.future" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Fondo (Canvas) -->
    <div id="futuristic-bg" class="bg-holder">
        <canvas id="net-canvas"></canvas>
    </div>

    <!-- Contenido principal (encima del canvas) -->
    <div class="container content-overlay">
        <h1 class="display-4 fw-bold text-white mb-3" id="typing-title" style="min-height: 1.2em;"></h1>
        <p class="lead text-white-50" id="typing-text" style="min-height: 1.5em;">
           
        </p>

        <div class="row g-4 perspective-container">
            <div class="col-md-6">
                <!-- Agregamos clase 'interactive-card' para el JS -->
                <div class="glass-card interactive-card">
                    <h3>Red de Distribución</h3>
                    <p>
                        Nuestros nodos logísticos se conectan entre si para optimizar las entregas a nivel nacional,
                        adaptándose dinámicamente a la demanda.
                    </p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="glass-card interactive-card">
                    <h3>Análisis de Datos</h3>
                    <p>
                        Procesamos miles de variables simultáneas para garantizar la calidad en cada bobina de papel,
                        utilizando algoritmos de vanguardia.
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- ====== Estilos mínimos ====== -->
    <style>
        /* El canvas cubre toda la pantalla por detrás del contenido */
        #futuristic-bg.bg-holder {
            position: fixed;
            inset: 0;
            z-index: 0;
            pointer-events: none;
            background: transparent;
        }

        .content-overlay {
            position: relative;
            z-index: 1;
            text-shadow: 0 2px 5px rgba(0,0,0,0.8); /* Sombra fuerte para legibilidad */
        }

        /* Tarjetas con efecto vidrio */
        .glass-card {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            padding: 1.25rem;
            color: #fff;
            backdrop-filter: blur(8px);
            
            /* Propiedades para el efecto 3D */
            transform-style: preserve-3d;
            transform: perspective(1000px);
            transition: transform 0.1s ease-out; /* Movimiento suave */
            will-change: transform;
        }

        /* Efecto de profundidad para el texto */
        .glass-card h3, 
        .glass-card p {
            transform: translateZ(20px); /* El texto flota sobre la tarjeta */
        }

        @media (prefers-reduced-motion: reduce) {
            #futuristic-bg { display: none !important; }
            .glass-card { transform: none !important; }
        }
    </style>

    <!-- ====== Script Canvas 2D + Efecto Tilt ====== -->
    <script>
        (function () {
            /* ------------------------------------------------
               EFECTO DE ESCRITURA (TYPEWRITER) - TÍTULO Y SUBTÍTULO
               ------------------------------------------------ */
            const titleText = "El Futuro de PAVECA";
            const subText = "Innovación, tecnología y redes de distribución interconectadas en constante movimiento.";

            const titleEl = document.getElementById('typing-title');
            const subEl = document.getElementById('typing-text');

            function typeLine(text, element, delay, callback) {
                let i = 0;
                setTimeout(() => {
                    function type() {
                        if (element && i < text.length) {
                            element.innerHTML += text.charAt(i);
                            i++;
                            setTimeout(type, 50); // Velocidad de escritura
                        } else if (callback) {
                            callback();
                        }
                    }
                    type();
                }, delay);
            }

            // Secuencia: Título -> Pausa -> Subtítulo
            typeLine(titleText, titleEl, 500, () => {
                typeLine(subText, subEl, 300, null);
            });

            /* ------------------------------------------------
               EFECTO TILT (MOVIMIENTO CON EL CURSOR)
               ------------------------------------------------ */
            const cards = document.querySelectorAll('.interactive-card');

            cards.forEach(card => {
                card.addEventListener('mousemove', (e) => {
                    const rect = card.getBoundingClientRect();
                    const x = e.clientX - rect.left; // Posición X dentro de la tarjeta
                    const y = e.clientY - rect.top;  // Posición Y dentro de la tarjeta

                    const centerX = rect.width / 2;
                    const centerY = rect.height / 2;

                    // Calcular rotación (máximo 10 grados)
                    // Multiplicamos por -1 en X para que incline "hacia" el mouse verticalmente
                    const rotateX = ((y - centerY) / centerY) * -10;
                    const rotateY = ((x - centerX) / centerX) * 10;

                    // Aplicar transformación
                    card.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale(1.02)`;
                });

                // Resetear al salir
                card.addEventListener('mouseleave', () => {
                    card.style.transform = 'perspective(1000px) rotateX(0) rotateY(0) scale(1)';
                });
            });

            /* ------------------------------------------------
               CANVAS BACKGROUND
               ------------------------------------------------ */
            const BASE_NODE_COUNT = 70;
            const MAX_DIST = 150;
            const SPEED = 0.60;
            const FPS = 30;
            const COLOR_POINT = 'rgba(255,255,255,0.2)'; // Puntos mucho más sutiles
            const COLOR_LINE_BASE = 'rgba(255,255,255,';

            const isMobile = window.matchMedia('(pointer: coarse)').matches;
            const prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

            const NODE_COUNT = isMobile ? Math.max(30, Math.round(BASE_NODE_COUNT * 0.6)) : BASE_NODE_COUNT;
            const EFFECT_MAX_DIST = isMobile ? Math.round(MAX_DIST * 0.8) : MAX_DIST;
            const EFFECT_SPEED = isMobile ? SPEED * 0.7 : SPEED;

            document.addEventListener('DOMContentLoaded', init, { once: true });

            function init() {
                if (prefersReduced) return;
                document.body.classList.add('page-futuro');

                const holder = document.getElementById('futuristic-bg');
                const canvas = document.getElementById('net-canvas');
                if (!holder || !canvas) return;

                const ctx = canvas.getContext('2d', { alpha: true });
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

                const nodes = new Array(NODE_COUNT).fill(0).map((_, i) => ({
                    id: i,
                    x: Math.random() * window.innerWidth,
                    y: Math.random() * window.innerHeight,
                    r: 2.2 + Math.random() * (4.5 - 2.2),
                    vx: (Math.random() - 0.5) * EFFECT_SPEED * 2,
                    vy: (Math.random() - 0.5) * EFFECT_SPEED * 2
                }));

                const CELL = EFFECT_MAX_DIST;
                function buildGrid() {
                    const grid = new Map();
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

                let running = true, last = 0, interval = 1000 / FPS;

                function step(ts) {
                    if (!running) { requestAnimationFrame(step); return; }
                    if (ts - last < interval) { requestAnimationFrame(step); return; }
                    last = ts;

                    for (let i = 0; i < nodes.length; i++) {
                        const n = nodes[i];
                        n.x += n.vx; n.y += n.vy;
                        if (n.x < 0 || n.x > w) n.vx *= -1;
                        if (n.y < 0 || n.y > h) n.vy *= -1;
                    }

                    const grid = buildGrid();
                    const max2 = EFFECT_MAX_DIST * EFFECT_MAX_DIST;

                    ctx.clearRect(0, 0, w, h);

                    ctx.lineWidth = 1;
                    for (let i = 0; i < nodes.length; i++) {
                        const a = nodes[i];
                        const cx = (a.x / CELL) | 0;
                        const cy = (a.y / CELL) | 0;

                        for (let ox = -1; ox <= 1; ox++) {
                            for (let oy = -1; oy <= 1; oy++) {
                                const key = (cx + ox) + ',' + (cy + oy);
                                const bucket = grid.get(key);
                                if (!bucket) continue;

                                for (let k = 0; k < bucket.length; k++) {
                                    const j = bucket[k];
                                    if (j <= i) continue;
                                    const b = nodes[j];
                                    const dx = a.x - b.x, dy = a.y - b.y;
                                    const d2 = dx * dx + dy * dy;
                                    if (d2 < max2) {
                                        const d = Math.sqrt(d2);
                                        const op = (1 - d / EFFECT_MAX_DIST) * 0.15; // Líneas más transparentes
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

                    ctx.fillStyle = COLOR_POINT;
                    for (let i = 0; i < nodes.length; i++) {
                        const n = nodes[i];
                        ctx.beginPath();
                        ctx.arc(n.x, n.y, n.r, 0, Math.PI * 2);
                        ctx.fill();
                    }

                    requestAnimationFrame(step);
                }

                let rzT;
                function onResize() {
                    clearTimeout(rzT);
                    rzT = setTimeout(() => {
                        dpr = Math.min(window.devicePixelRatio || 1, 1.5);
                        resize();
                    }, 120);
                }

                function onVisibility() { running = !document.hidden; }

                let io = null;
                if ('IntersectionObserver' in window) {
                    io = new IntersectionObserver(([entry]) => {
                        running = entry.isIntersecting && !document.hidden;
                    });
                    io.observe(holder);
                }

                resize();
                requestAnimationFrame(step);

                window.addEventListener('resize', onResize);
                document.addEventListener('visibilitychange', onVisibility);

                window.addEventListener('beforeunload', () => {
                    running = false;
                    window.removeEventListener('resize', onResize);
                    document.removeEventListener('visibilitychange', onVisibility);
                    if (io) io.disconnect();
                    document.body.classList.remove('page-futuro');
                });
            }
        })();
    </script>

</asp:Content>
