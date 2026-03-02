<%@ Page Title="Acceso PAVECA" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Prueba.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- 1. Fondo Futurista (Canvas + Gradiente PAVECA) -->
    <div id="futuristic-bg" class="bg-holder">
        <canvas id="net-canvas"></canvas>
    </div>

    <!-- 2. Contenido Principal -->
    <div class="container content-overlay d-flex justify-content-center align-items-center" style="min-height: 85vh;">
        
        <!-- Tarjeta con efecto vidrio (Tinte Verde) -->
        <div class="glass-card p-5 fade-in-up" style="width: 100%; max-width: 420px;">
            
            <div class="text-center mb-5">
                <!-- Título con sombra para resaltar sobre el verde -->
                <h2 class="fw-bold text-white mb-1" style="text-shadow: 0 2px 4px rgba(0,0,0,0.3);">PAVECA</h2>
                <p class="text-white-50 small text-uppercase" style="letter-spacing: 2px;">Portal Corporativo</p>
            </div>

            <!-- Campo Usuario -->
            <div class="form-group mb-4">
                <label class="text-white small text-uppercase mb-2" style="letter-spacing: 1px; opacity:0.9;">Usuario / ID</label>
                <div class="input-group">
                    <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control futuristic-input" placeholder="Ingrese su usuario"></asp:TextBox>
                </div>
            </div>

            <!-- Campo Contraseña -->
            <div class="form-group mb-5">
                <label class="text-white small text-uppercase mb-2" style="letter-spacing: 1px; opacity:0.9;">Contraseña</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control futuristic-input" TextMode="Password" placeholder="••••••••"></asp:TextBox>
            </div>

            <!-- Botón de Acción (Blanco para contraste o Dorado si prefieres) -->
            <asp:Button ID="btnLogin" runat="server" Text="INGRESAR" CssClass="btn btn-light w-100 fw-bold py-3 btn-glow" OnClick="btnLogin_Click" />

            <!-- Mensaje de Error -->
            <div class="mt-4 text-center" style="min-height: 24px;">
                <asp:Label ID="lblError" runat="server" CssClass="text-warning small fw-bold" Visible="false"></asp:Label>
            </div>
        </div>

    </div>

    <!-- 3. Estilos CSS (Tema Verde PAVECA) -->
    <style>
        /* Fondo con Gradiente Verde PAVECA */
        #futuristic-bg.bg-holder {
            position: fixed;
            inset: 0;
            z-index: 0;
            pointer-events: none;
            /* Degradado desde un verde muy oscuro hasta el verde PAVECA */
            background: linear-gradient(135deg, #002b15 0%, #005A36 50%, #007a48 100%);
        }

        .content-overlay {
            position: relative;
            z-index: 1;
        }

        /* Tarjeta de Vidrio con tinte esmeralda */
        .glass-card {
            /* Fondo semitransparente con un toque de verde oscuro */
            background: rgba(0, 40, 20, 0.35);
            /* Borde sutil */
            border: 1px solid rgba(255, 255, 255, 0.15);
            /* Sombra profunda para dar profundidad */
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 20px;
        }

        /* Inputs Futuristas */
        .futuristic-input {
            background: rgba(0, 0, 0, 0.25) !important; /* Un poco más oscuro para legibilidad */
            border: 1px solid rgba(255, 255, 255, 0.15) !important;
            color: #fff !important;
            border-radius: 8px;
            padding: 12px;
        }
        .futuristic-input:focus {
            background: rgba(0, 0, 0, 0.4) !important;
            border-color: #4ade80 !important; /* Borde verde brillante al enfocar */
            box-shadow: 0 0 15px rgba(74, 222, 128, 0.2);
            outline: none;
        }
        .futuristic-input::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }

        /* Botón con efecto Glow */
        .btn-glow {
            border-radius: 50px;
            letter-spacing: 1px;
            color: #005A36; /* Texto verde PAVECA */
            transition: all 0.3s ease;
        }
        .btn-glow:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 20px rgba(255, 255, 255, 0.4);
        }

        /* Animación de entrada suave */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in-up {
            animation: fadeInUp 0.8s ease-out forwards;
        }
    </style>

    <!-- 4. Script de Animación de Red (Sin cambios, funciona perfecto sobre verde) -->
    <script>
        (function () {
            const BASE_NODE_COUNT = 70;
            const MAX_DIST = 150;
            const SPEED = 0.60;
            const FPS = 30;
            const COLOR_POINT = 'rgba(255,255,255,0.85)';
            const COLOR_LINE_BASE = 'rgba(255,255,255,';

            const isMobile = window.matchMedia('(pointer: coarse)').matches;
            const prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

            const NODE_COUNT = isMobile ? Math.max(30, Math.round(BASE_NODE_COUNT * 0.6)) : BASE_NODE_COUNT;
            const EFFECT_MAX_DIST = isMobile ? Math.round(MAX_DIST * 0.8) : MAX_DIST;
            const EFFECT_SPEED = isMobile ? SPEED * 0.7 : SPEED;

            document.addEventListener('DOMContentLoaded', init, { once: true });

            function init() {
                if (prefersReduced) return;

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

                const POINT_MIN = 2.2, POINT_MAX = 4.5;
                const nodes = new Array(NODE_COUNT).fill(0).map((_, i) => ({
                    id: i,
                    x: Math.random() * window.innerWidth,
                    y: Math.random() * window.innerHeight,
                    r: POINT_MIN + Math.random() * (POINT_MAX - POINT_MIN),
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

                let running = true, animId = null, last = 0, interval = 1000 / FPS;

                function step(ts) {
                    if (!running) { animId = requestAnimationFrame(step); return; }
                    if (ts - last < interval) { animId = requestAnimationFrame(step); return; }
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
                                        const op = (1 - d / EFFECT_MAX_DIST) * 0.6;
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

                    animId = requestAnimationFrame(step);
                }

                let rzT;
                function onResize() {
                    clearTimeout(rzT);
                    rzT = setTimeout(() => {
                        dpr = Math.min(window.devicePixelRatio || 1, 1.5);
                        resize();
                    }, 120);
                }

                function onVisibility() {
                    running = !document.hidden;
                }

                let io = null;
                if ('IntersectionObserver' in window) {
                    io = new IntersectionObserver(([entry]) => {
                        running = entry.isIntersecting && !document.hidden;
                    });
                    io.observe(holder);
                }

                resize();
                animId = requestAnimationFrame(step);

                window.addEventListener('resize', onResize);
                document.addEventListener('visibilitychange', onVisibility);

                window.addEventListener('beforeunload', () => {
                    running = false;
                    cancelAnimationFrame(animId);
                    window.removeEventListener('resize', onResize);
                    document.removeEventListener('visibilitychange', onVisibility);
                    if (io) io.disconnect();
                });
            }
        })();
    </script>

</asp:Content>