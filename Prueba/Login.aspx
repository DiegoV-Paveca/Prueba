<%@ Page Title="Acceso" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Prueba.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        /* --- 1. CORRECCIÓN DE MASTERPAGE (CRÍTICO) --- */
        /* Ocultamos forzosamente la Navbar, el Header y el Footer de la plantilla principal */
        header, nav, footer, .navbar, .footer, #footer, .container-fluid > nav {
            display: none !important;
        }

        /* Eliminamos márgenes que la MasterPage pueda estar agregando al body */
        body {
            padding: 0 !important;
            margin: 0 !important;
            overflow: hidden !important; /* Bloqueamos el scroll de la página base */
        }

        /* --- 2. VARIABLES PAVECA --- */
        :root {
            --pv-primary: #007853; /* Verde PAVECA Oficial */
            --pv-dark: #004d35;
            --pv-light: #00a672;
            --text-white: #ffffff;
        }

        /* --- 3. LOGIN A PANTALLA COMPLETA --- */
        .full-screen-login {
            position: fixed; /* Fijo respecto a la ventana */
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            /* Z-Index máximo para estar ENCIMA de todo (incluso de la navbar si intentara verse) */
            z-index: 2147483647; 
            
            /* Fondo Verde PAVECA */
            background: linear-gradient(135deg, var(--pv-dark) 0%, var(--pv-primary) 50%, var(--pv-light) 100%);
            
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Textura de ruido suave */
        .noise-overlay {
            position: absolute;
            inset: 0;
            opacity: 0.05;
            pointer-events: none;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)'/%3E%3C/svg%3E");
        }

        /* Contenedor interno */
        .login-wrapper {
            position: relative;
            z-index: 10;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 3rem;
            width: 100%;
            max-width: 1100px;
            padding: 20px;
        }

        @media (min-width: 992px) {
            .login-wrapper {
                flex-direction: row;
                gap: 5rem;
            }
        }

        /* --- ROLLO 3D --- */
        .roll-scene {
            position: relative;
            width: 280px;
            height: 280px;
            perspective: 1000px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .roll-object {
            position: relative;
            width: 200px;
            height: 200px;
            transform-style: preserve-3d;
            transform: rotateX(var(--rx, 30deg)) rotateY(var(--ry, -30deg));
            transition: transform 0.1s ease-out;
        }

        .roll-layer {
            position: absolute;
            inset: 0;
            border-radius: 50%;
            border: 1px solid #e5e5e5;
            background: radial-gradient(circle, #8B4513 25%, #f5f5f5 26%, #ffffff 100%);
            width: 100%;
            height: 100%;
        }

        .peeling-sheet {
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 130px;
            height: 160px;
            background: linear-gradient(to bottom, #ffffff, #f8f8f8);
            transform-origin: top;
            transform: translateZ(120px) rotateX(45deg) translateY(80px) translateX(-50%);
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            border-radius: 2px;
        }

        /* --- FORMULARIO --- */
        .login-column {
            width: 100%;
            max-width: 400px;
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .brand-title h1 {
            font-family: 'Segoe UI', sans-serif;
            font-size: 3.5rem;
            font-weight: 1200;
            line-height: 1;
            margin: 0;
            color: white;
            letter-spacing: -1px;
            text-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        
        .brand-title span {
            color: #a7f3d0; /* Verde menta claro para contraste */
        }

        .brand-subtitle {
            color: rgba(255,255,255,0.9);
            font-size: 1.1rem;
            margin-top: 10px;
            font-weight: 300;
        }

        /* Tarjeta Blanca */
        .card-login {
            background: white;
            border-radius: 16px;
            padding: 8px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.3);
        }

        .input-group-custom {
            display: flex;
            align-items: center;
            padding: 14px 18px;
        }

        .input-icon {
            width: 22px;
            height: 22px;
            color: #9ca3af;
            margin-right: 12px;
        }

        .input-clean {
            border: none;
            outline: none;
            width: 100%;
            font-size: 1rem;
            color: #374151;
            font-family: inherit;
        }

        .input-divider {
            height: 1px;
            background: #f3f4f6;
            margin: 0 10px;
        }

        /* Botón */
        .btn-paveca {
            background-color: white;
            color: var(--pv-primary);
            font-weight: 800;
            border: none;
            border-radius: 50px;
            padding: 14px 30px;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
            width: auto;
            min-width: 140px;
        }

        .btn-paveca:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
            background-color: #f9fafb;
        }

        .footer-copy {
            position: absolute;
            bottom: 20px;
            width: 100%;
            text-align: center;
            color: rgba(255,255,255,0.4);
            font-size: 0.75rem;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        /* --- 4. MODAL MANTENIMIENTO --- */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(4px);
            z-index: 2147483648; /* Uno más que el login */
            display: none; /* Oculto por defecto */
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .modal-overlay.active {
            display: flex;
            opacity: 1;
        }

        .modal-box {
            background: white;
            padding: 2rem;
            border-radius: 16px;
            width: 90%;
            max-width: 400px;
            text-align: center;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            transform: scale(0.95);
            transition: transform 0.3s ease;
        }

        .modal-overlay.active .modal-box {
            transform: scale(1);
        }

        .modal-icon {
            width: 48px;
            height: 48px;
            background: #fee2e2;
            color: #ef4444;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem auto;
        }

        .modal-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 0.5rem;
            font-family: 'Segoe UI', sans-serif;
        }

        .modal-text {
            color: #6b7280;
            margin-bottom: 1.5rem;
            line-height: 1.5;
        }

        .modal-btn {
            background: var(--pv-primary);
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }

        .modal-btn:hover {
            background: var(--pv-dark);
        }
    </style>

    <!-- Contenedor PRINCIPAL (Fijo y encima de todo) -->
    <div class="full-screen-login" id="mainContainer">
        
        <div class="noise-overlay"></div>

        <div class="login-wrapper">
            
            <!-- Rollo 3D -->
            <div class="roll-scene">
                <div class="roll-object" id="paperRoll3D">
            </div>
            </div>

            <!-- Formulario -->
            <div class="login-column">
                <div class="brand-title">
                    <h1>Inicio de Sesión</h1>
                    <p class="brand-subtitle">Portal Corporativo PAVECA</p>
                </div>

                <div class="card-login">
                    <div class="input-group-custom">
                        <!-- Icono User -->
                        <svg class="input-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="input-clean" placeholder="Usuario"></asp:TextBox>
                    </div>
                    
                    <div class="input-divider"></div>

                    <div class="input-group-custom">
                        <!-- Icono Lock -->
                        <svg class="input-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path></svg>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="input-clean" TextMode="Password" placeholder="Contraseña"></asp:TextBox>
                    </div>
                </div>

                <div style="display:flex; justify-content:space-between; align-items:center; padding: 0 10px;">
                    <a href="javascript:void(0);" onclick="openModal()" style="color:rgba(255,255,255,0.6); text-decoration:none; font-size:0.85rem; font-weight:500;">¿Olvidó su clave?</a>
                    <asp:Button ID="btnLogin" runat="server" Text="INGRESAR" CssClass="btn-paveca" OnClick="btnLogin_Click" />
                </div>

                <div style="min-height:20px; text-align:center;">
                    <asp:Label ID="lblError" runat="server" ForeColor="#fca5a5" Font-Bold="true" Visible="false"></asp:Label>
                </div>
            </div>
        </div>

        <div class="footer-copy">© 2026 Papeles Venezolanos C.A.</div>

        <!-- Modal Mantenimiento -->
        <div class="modal-overlay" id="maintenanceModal">
            <div class="modal-box">
                <div class="modal-icon">
                    <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path></svg>
                </div>
                <h3 class="modal-title">Olvidó su contraseña.</h3>
                <p class="modal-text">Por favor, contacte al departamento de TI si requiere asistencia.</p>
                <button class="modal-btn" onclick="closeModal()">Entendido</button>
            </div>
        </div>
    </div>

    <!-- Script para el efecto 3D -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const rollContainer = document.getElementById('paperRoll3D');
            const sheet = document.getElementById('peelingSheet');
            const container = document.getElementById('mainContainer');

            const layerCount = 40;
            const layerSpacing = 3;

            const fragment = document.createDocumentFragment();

            for (let i = 0; i < layerCount; i++) {
                const layer = document.createElement('div');
                layer.className = 'roll-layer';
                layer.style.transform = 'translateZ(' + (i * layerSpacing) + 'px)';
                layer.style.zIndex = i;
                if (i === layerCount - 1) {
                    layer.style.boxShadow = '0 10px 30px rgba(0,0,0,0.2)';
                }
                fragment.appendChild(layer);
            }

            rollContainer.insertBefore(fragment, sheet);

            const totalDepth = layerCount * layerSpacing;
            sheet.style.transform = 'translateZ(' + totalDepth + 'px) rotateX(45deg) translateY(80px) translateX(-50%)';

            container.addEventListener('mousemove', function (e) {
                const width = window.innerWidth;
                const height = window.innerHeight;
                const x = (e.clientX / width) - 0.5;
                const y = (e.clientY / height) - 0.5;
                const rotateX = 30 + (y * -30);
                const rotateY = -30 + (x * 30);
                rollContainer.style.setProperty('--rx', rotateX + 'deg');
                rollContainer.style.setProperty('--ry', rotateY + 'deg');
            });

            // Listener para cerrar modal al hacer click fuera
            const modal = document.getElementById('maintenanceModal');
            if (modal) {
                modal.addEventListener('click', function (e) {
                    if (e.target === this) {
                        closeModal();
                    }
                });
            }
        });

        // Funciones globales para el modal
        function openModal() {
            const modal = document.getElementById('maintenanceModal');
            if (modal) {
                modal.style.display = 'flex';
                setTimeout(() => {
                    modal.classList.add('active');
                }, 10);
            }
        }

        function closeModal() {
            const modal = document.getElementById('maintenanceModal');
            if (modal) {
                modal.classList.remove('active');
                setTimeout(() => {
                    modal.style.display = 'none';
                }, 300);
            }
        }
    </script>

</asp:Content>
