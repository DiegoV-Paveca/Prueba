<%@ Page Title="Contacto - Paveca" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Prueba.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Estilos locales para esta página (o muévelos a tu Site.css) -->
    <style>
        .text-paveca { color: #007853; }
        .bg-paveca-light { background-color: #f8fcfb; } /* Un fondo muy sutil */
        .hover-card { transition: transform 0.3s ease, box-shadow 0.3s ease; }
        .hover-card:hover { transform: translateY(-5px); box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important; }
        .contact-icon { font-size: 2rem; color: #007853; margin-bottom: 1rem; }
        a.link-no-decoration { text-decoration: none; }
    </style>

    <div class="container my-5">
        <!-- Recuadro principal -->
        <div class="bg-white p-5 mx-auto shadow-sm" style="max-width:1200px; border-radius:8px; border-top: 5px solid #007853;">

            <div class="text-center mb-5">
                <h1 class="fw-bold text-paveca">Contáctanos</h1>
                <p class="text-muted mt-2">Estamos aquí para ayudarte en lo que necesites.</p>
                <hr class="mx-auto" style="width: 60px; height: 3px; background-color: #007853; opacity: 1;" />
            </div>

            <!-- Sección de llamada (Call to Action) -->
            <div class="text-center mb-5 p-4 ">
                <p class="mb-2 fs-5">Línea de atención</p>
                <!-- Enlace tel: para que funcione en celulares -->
                <a href="tel:08007283221" class="fw-bold fs-3 text-paveca link-no-decoration">
                    <i class="bi bi-telephone-fill me-2"></i>0800 PAVECA 1
                </a>
            </div>

            <!-- Tarjetas -->
            <div class="row g-4 justify-content-center">

                <!-- Soporte técnico -->
                <div class="col-md-5">
                    <div class="card border-0 shadow-sm h-100 p-4 text-center hover-card">
                        <div class="card-body">
                            <!-- Icono (Usando Bootstrap Icons o FontAwesome si tienes) -->
                            <div class="contact-icon">⚙️</div> 
                            <h5 class="fw-bold mb-2">Soporte Técnico</h5>
                            <p class="text-muted small mb-4">Consultas técnicas, problemas de acceso y configuración de cuenta.</p>

                            <!-- CORREGIDO: href coincide con el texto -->
                            <a href="mailto:Support@paveca.com.ve" class="btn btn-outline-success rounded-pill px-4">
                                Enviar correo
                            </a>
                            <div class="mt-2 text-muted small">Support@paveca.com.ve</div>
                        </div>
                    </div>
                </div>

                <!-- Marketing -->
                <div class="col-md-5">
                    <div class="card border-0 shadow-sm h-100 p-4 text-center hover-card">
                        <div class="card-body">
                            <div class="contact-icon">📢</div>
                            <h5 class="fw-bold mb-2">Marketing</h5>
                            <p class="text-muted small mb-4">Alianzas comerciales, campañas y solicitudes corporativas.</p>

                            <!-- CORREGIDO: href coincide con el texto -->
                            <a href="mailto:Marketing@paveca.com.ve" class="btn btn-outline-success rounded-pill px-4">
                                Enviar correo
                            </a>
                            <div class="mt-2 text-muted small">Marketing@paveca.com.ve</div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>