<%-- 
    Document   : perfilusuario
    Created on : 16/03/2023, 13:53:42
    Author     : Alex
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.time.*"%>
<!DOCTYPE html>
<%
    session.setAttribute("ORDER", "1");
    session.setAttribute("ORDER2", " ASC");
    session.setAttribute("SEARCH", "0");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Meu Perfil</title>
        <link rel="icon" href="images/Logo2.png">
        <%@include file="WEB-INF/jspf/css.jspf" %>
        <%@include file="WEB-INF/jspf/scripts.jspf" %>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <%if (Integer.parseInt(request.getParameter("auto")) != 0) {
                DrivingSchool school = DrivingSchool.getDrivingSchoolView(request.getParameter("auto"));
                ArrayList<Service> servico = new ArrayList<>();
                servico = Service.getServicosAutoescola(request.getParameter("auto"));
        %>
        <div class="container-fluid" style="margin-bottom: 30px; margin-top: 30px">
            <div class="container-fluid caixa">
                <div class="row justify-content-center">
                    <div class="col-2">
                        <img src="images/carro.png" class="card-img-top" style="border: 1px solid black">
                    </div>
                    <div class="col-2" style="text-align: left; margin-top: 2.8%">
                        <h4><%= school.getNome()%></h4>
                        <h4>Descri��o: <%= school.getDescricao()%></h4>
                        <h4>Avalia��o: <%= school.getrAvalaicao()%></h4>
                    </div>
                    <div class="col-1"></div>
                    <div class="col" style="border: 1px solid black; text-align: left; margin-right: 10px; margin-top: 20px; margin-bottom: 30px">
                        <h4 style="padding-top: 50px">Endere�o: <%= school.getEndereco()%>, <%= school.getBairro()%>, <%= school.getCidade()%>. CEP: <%= school.getCep()%></h4>
                        <h4>Contatos - E-mail: <%= school.getEmail()%>; Fone:<%= school.getTelefone()%></h4>
                    </div>
                    <hr style="margin-top: 10px; border-width: 3px">
                </div>
                <% for (Service s : servico) {%>
                <div class="row justify-content-center" style="border: 1px solid black; margin-bottom: 30px; margin-left: 0.00001px; margin-right: 0.000001px">
                    <div class="col-4" style="padding-top: 35px">
                        <h4><%= s.getDescricao()%></h4>
                    </div>
                    <div class="col">
                        <h4>Tipo: <% if (s.getTipo() == 1) {
                                out.print("Pr�tica");
                            } else {
                                out.print("Te�rica");
                            }%></h4>
                        <h4>Inicia: <%= s.getHoraInicio()%> - Termina <%= s.getHoraFim()%></h4>
                        <h4>Valor R$:<%= s.getValor()%></h4>
                    </div>
                </div>
                <%}%>
                <div class="row justify-content-center">
                    <div class="col">
                        <a class="btn btn-primary" href="<%
                            if (session.getAttribute("user") == null) {
                                out.print("login.jsp");
                            } else {
                                out.print("#");
                            }%>">Tenho Interesse</a>
                    </div>
                </div>
            </div>
        </div>

        <%} else if (session.getAttribute("user") == null && session.getAttribute("school") == null) {
                out.print("Voc� deve realizar login para acessar o conte�do desta p�gina");
            }%>
        <%@include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>