<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Prueba.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Recuadro principal EXACTO como pediste -->
    <div class="bg-white p-5 my-3 mx-auto" style="max-width:1200px;border-radius:2px;">

        <div class="text-center mb-4">
            <h1 class="fw-bold" style="color:#007853;">Contacto</h1>
                    <hr class="mt-3" style="opacity:.15;" />
        </div>

        <p class="text-center mb-5" style="color:#000;font-size:1.1rem;">
            Estamos aquí para ayudarte. Puedes comunicarte llamando a nuestra línea de atención: <strong><span style="color:#007853;">0800 PAVECA 1</span></strong>
        </p>


        <!-- Tarjetas dentro del mismo recuadro -->
        <div class="row g-4 justify-content-center">

            <!-- Soporte técnico -->
            <div class="col-md-5">
                <div class="card border-0 shadow-sm h-100 p-4 text-center" style="border-radius:10px;">
                    <h5 class="fw-bold mb-2">Soporte Técnico</h5>
                    <p class="text-muted">Consultas técnicas, problemas de acceso y más.</p>

                    <a href="mailto:Support@example.com" class="fw-bold" style="color:#00509e;">
                        Support@paveca.com.ve
                    </a>
                </div>
            </div>

            <!-- Marketing -->
            <div class="col-md-5">
                <div class="card border-0 shadow-sm h-100 p-4 text-center" style="border-radius:10px;">
                    <h5 class="fw-bold mb-2">Marketing</h5>
                    <p class="text-muted">Alianzas, campañas y solicitudes corporativas.</p>

                    <a href="mailto:Marketing@example.com" class="fw-bold" style="color:#00509e;">
                        Marketing@paveca.com.ve
                    </a>
                </div>
            </div>

        </div>

    </div>

</asp:Content>
