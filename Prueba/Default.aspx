<%@ Page Title="Pagina Principal" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Prueba._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="container py-4">
        <section class="pv-hero">
            <div class="container">
                <div class="row align-items-center g-3">
                    <div class="col-lg-7">
                        <h1>Soluciones papeleras para un país que produce</h1>
                        <p class="lead">
                            Somos una industria papelera líder en Venezuela. Fabricamos y convertimos productos
                            confiables para el cuidado del hogar y uso industrial, con procesos responsables y
                            calidad consistente.
                        </p>

                        <div class="d-flex flex-wrap gap-3 btn-stack">
                            <a href="/Contact.aspx" class="btn-primary-invert">Habla con nosotros</a>
                            <a href="/About.aspx" class="btn btn-outline-light">Conoce PAVECA</a>
                        </div>

                        <div class="d-flex align-items-center gap-3 mt-4" style="color:rgba(255,255,255,.85);">
                            <span style="opacity:.45;">•</span>
                            <small>Compromiso con la calidad</small>
                            <span style="opacity:.45;">•</span>
                            <small>Fabricación y conversión</small>
                            <span style="opacity:.45;">•</span>
                            <small>Enfoque en sostenibilidad</small>

                        </div>
                    </div>
                    <div class="col-lg-5">
                        <!-- Espacio limpio/minimal en lugar de mockup pesado -->
                        <div class="pv-kpis">
                            <div class="row g-3 text-center">
                                <div class="col-4 pv-kpi">
                                    <h3>73</h3>
                                    <p>Años de trayectoria</p>
                                </div>
                                <div class="col-4 pv-kpi">
                                    <h3>+X</h3>
                                    <p>Colaboradores</p>
                                </div>
                                <div class="col-4 pv-kpi">
                                    <h3>100%</h3>
                                    <p>Lideres del mercado</p>
                                </div>
                            </div>
                        </div>
                        <p class="mt-3 mb-0" style="color:rgba(255,255,255,.85);">
                            Cadena integrada: pulpa, papel y conversión.
                        </p>
                    </div>
                </div>
            </div>
        </section>

        <!-- LÍNEA DE PRODUCTO / CAPACIDADES -->
        <section class="my-5">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="pv-card">
                        <div class="pv-icon">
                            <i class="bi bi-layers"></i>
                        </div>
                        <h5>Papel & Celulosa</h5>
                        <p>Fabricación de papeles base con control de calidad en cada bobina.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="pv-card">
                        <div class="pv-icon">
                            <i class="bi bi-box-seam"></i>
                        </div>
                        <h5>Conversión & Empaque</h5>
                        <p>Toallas, servilletas, tissue y soluciones listas para retail y B2B.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="pv-card">
                        <div class="pv-icon">
                        <i class="bi bi-bar-chart-line"></i>
                        </div>
                        <h5>Sostenibilidad</h5>
                        <p>Uso eficiente de agua y energía, reciclaje y mejora continua.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA FINAL -->
        <section class="pv-cta my-4">
            <div class="row align-items-center g-3">
                <div class="col-lg-8">
                    <h4 style="margin:0 0 .25rem 0; color:var(--pv-ink);">¿Hablamos sobre tus necesidades de papel?</h4>
                    <p style="margin:0; color:var(--pv-muted);">
                        Nuestro equipo te acompaña desde la especificación técnica hasta la entrega.
                    </p>
                </div>
                <div class="col-lg-4 text-lg-end">
                    <a href="/Contact.aspx" class="btn btn-success" style="background:var(--pv-primary); border-color:var(--pv-primary);">
                        Contactar
                    </a>
                </div>
            </div>
        </section>

    </main>
</asp:Content>