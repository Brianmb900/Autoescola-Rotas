<%-- 
    Document   : cadastro
    Created on : 9 de mar de 2023, 19:51:52
    Author     : user
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.time.*"%>
<!DOCTYPE html>
<%
    String admException = null;
    ArrayList<User> users = new ArrayList<>();
    ArrayList<User> userSearch = new ArrayList<>();
    int limite = 5;
    int total = 0;
    try {
        int pageid = Integer.parseInt(request.getParameter("page"));
        if (pageid == 1) {
        } else {
            pageid = (pageid - 1) * limite + 1;
        }
        users = User.getUsers(pageid, limite, (session.getAttribute("ORDER").toString()), (session.getAttribute("ORDER2").toString()));
        userSearch = User.searchUser(session.getAttribute("SEARCH").toString(), pageid, limite, session.getAttribute("ORDER").toString(), session.getAttribute("ORDER2").toString());
        if (session.getAttribute("SEARCH").toString().equals("0")) {
            total = User.getTotalUsers().size();
        } else {
            total = User.searchUser(session.getAttribute("SEARCH").toString(), pageid, 100000, session.getAttribute("ORDER").toString(), session.getAttribute("ORDER2").toString()).size();
        }
        if (request.getParameter("cadCli") != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            int adm = 0;
            String nome = request.getParameter("nome");
            String sobrenome = request.getParameter("sobrenome");
            String email = request.getParameter("email");
            String telefone = request.getParameter("phone");
            LocalDate nascimento = LocalDate.parse(request.getParameter("bDate"));
            LocalDate curDate = LocalDate.now();
            if (Period.between(nascimento, curDate).getYears() < 18) {
                admException = "O aluno ser maior de idade!";
                throw new java.lang.RuntimeException(admException);
            } else if (Period.between(nascimento, curDate).getYears() > 130) {
                admException = "Imortalidade (Ainda) N�o Existe!";
                throw new java.lang.RuntimeException(admException);
            }
            String Sexo = request.getParameter("sex");
            char sexo = Sexo.charAt(0);
            String senha = request.getParameter("password");
            String senha2 = request.getParameter("pass2");
            if (senha.equals(senha2)) {
            } else {
                admException = "Senhas N�o Correspondentes!";
                throw new java.lang.RuntimeException(admException);
            }
            User user = new User(
                    id,
                    adm,
                    nome,
                    sobrenome,
                    email,
                    senha,
                    telefone,
                    nascimento,
                    sexo
            );
            User.addUser(user);
            response.sendRedirect("http://localhost:8080/IRotas/administracao.jsp?page=" + request.getParameter("page"));
        }

        if (request.getParameter("altCli") != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            int adm = Integer.parseInt(request.getParameter("adm"));
            String nome = request.getParameter("nome");
            String sobrenome = request.getParameter("sobrenome");
            String email = request.getParameter("e-mail");
            String telefone = request.getParameter("phone");
            LocalDate nascimento = LocalDate.parse(request.getParameter("bDate"));
            LocalDate curDate = LocalDate.now();
            if (Period.between(nascimento, curDate).getYears() < 18) {
                admException = "Voc� deve ser maior de idade!";
                throw new java.lang.RuntimeException(admException);
            } else if (Period.between(nascimento, curDate).getYears() > 130) {
                admException = "Imortalidade (Ainda) N�o Existe!";
                throw new java.lang.RuntimeException(admException);
            }
            char sexo = ((User) session.getAttribute("user")).getSexo();
            String senha = "0";
            User user = new User(
                    id,
                    adm,
                    nome,
                    sobrenome,
                    email,
                    senha,
                    telefone,
                    nascimento,
                    sexo
            );
            User.alterarUser(user);
            response.sendRedirect("http://localhost:8080/IRotas/administracao.jsp?page=" + request.getParameter("page"));
        }

        if (request.getParameter("delCli") != null) {
            int idenCli = Integer.parseInt(request.getParameter("idenCliDel"));
            User.deleteUser(idenCli);
            response.sendRedirect("http://localhost:8080/IRotas/administracao.jsp?page=" + request.getParameter("page"));
        }

        if (request.getParameter("altSenha") != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            String senhaNova1 = request.getParameter("passNew1");
            String senhaNova2 = request.getParameter("passNew2");
            if (senhaNova1.equals(senhaNova2)) {
                User.alterarSenhaUser(senhaNova1, id);
            } else {
                admException = "Senhas N�o Correspondentes!";
                throw new java.lang.RuntimeException(admException);
            }
        }

        //ORDENA��ES
        if (request.getParameter("orderCliId") != null) {
            if (session.getAttribute("ORDER").toString().equals("1") && session.getAttribute("ORDER2").toString().equals(" ASC")) {
                session.setAttribute("ORDER", "1");
                session.setAttribute("ORDER2", " DESC");
            } else {
                session.setAttribute("ORDER", "1");
                session.setAttribute("ORDER2", " ASC");
            }
            response.sendRedirect("http://localhost:8080/IRotas/administracao.jsp?page=" + request.getParameter("page"));
        }

        if (request.getParameter("orderCliAdm") != null) {
            if (session.getAttribute("ORDER").toString().equals("2") && session.getAttribute("ORDER2").toString().equals(" ASC")) {
                session.setAttribute("ORDER", "2");
                session.setAttribute("ORDER2", " DESC");
            } else {
                session.setAttribute("ORDER", "2");
                session.setAttribute("ORDER2", " ASC");
            }
            response.sendRedirect("http://localhost:8080/IRotas/administracao.jsp?page=" + request.getParameter("page"));
        }

        if (request.getParameter("orderCliNome") != null) {
            if (session.getAttribute("ORDER").toString().equals("3") && session.getAttribute("ORDER2").toString().equals(" ASC")) {
                session.setAttribute("ORDER", "3");
                session.setAttribute("ORDER2", " DESC");
            } else {
                session.setAttribute("ORDER", "3");
                session.setAttribute("ORDER2", " ASC");
            }
            response.sendRedirect("http://localhost:8080/IRotas/administracao.jsp?page=" + request.getParameter("page"));
        }

        if (request.getParameter("orderCliSnome") != null) {
            if (session.getAttribute("ORDER").toString().equals("4") && session.getAttribute("ORDER2").toString().equals(" ASC")) {
                session.setAttribute("ORDER", "4");
                session.setAttribute("ORDER2", " DESC");
            } else {
                session.setAttribute("ORDER", "4");
                session.setAttribute("ORDER2", " ASC");
            }
            response.sendRedirect("http://localhost:8080/IRotas/administracao.jsp?page=" + request.getParameter("page"));
        }

        if (request.getParameter("orderCliEmail") != null) {
            if (session.getAttribute("ORDER").toString().equals("5") && session.getAttribute("ORDER2").toString().equals(" ASC")) {
                session.setAttribute("ORDER", "5");
                session.setAttribute("ORDER2", " DESC");
            } else {
                session.setAttribute("ORDER", "5");
                session.setAttribute("ORDER2", " ASC");
            }
            response.sendRedirect("http://localhost:8080/IRotas/administracao.jsp?page=" + request.getParameter("page"));
        }

        if (request.getParameter("orderCliTele") != null) {
            if (session.getAttribute("ORDER").toString().equals("7") && session.getAttribute("ORDER2").toString().equals(" ASC")) {
                session.setAttribute("ORDER", "7");
                session.setAttribute("ORDER2", " DESC");
            } else {
                session.setAttribute("ORDER", "7");
                session.setAttribute("ORDER2", " ASC");
            }
            response.sendRedirect("http://localhost:8080/IRotas/administracao.jsp?page=" + request.getParameter("page"));
        }

        if (request.getParameter("orderCliNasci") != null) {
            if (session.getAttribute("ORDER").toString().equals("8") && session.getAttribute("ORDER2").toString().equals(" ASC")) {
                session.setAttribute("ORDER", "8");
                session.setAttribute("ORDER2", " DESC");
            } else {
                session.setAttribute("ORDER", "8");
                session.setAttribute("ORDER2", " ASC");
            }
            response.sendRedirect("http://localhost:8080/IRotas/administracao.jsp?page=" + request.getParameter("page"));
        }

        if (request.getParameter("orderCliSexo") != null) {
            if (session.getAttribute("ORDER").toString().equals("9") && session.getAttribute("ORDER2").toString().equals(" ASC")) {
                session.setAttribute("ORDER", "9");
                session.setAttribute("ORDER2", " DESC");
            } else {
                session.setAttribute("ORDER", "9");
                session.setAttribute("ORDER2", " ASC");
            }
            response.sendRedirect("http://localhost:8080/IRotas/administracao.jsp?page=" + request.getParameter("page"));
        }
        //FIM ORDENA��ES
        if (request.getParameter("searchCli") != null) {
            session.setAttribute("SEARCH", request.getParameter("search"));
            session.setAttribute("ORDER", "1");
            session.setAttribute("ORDER2", " ASC");
            response.sendRedirect("http://localhost:8080/IRotas/administracao.jsp?page=1");
        }

        if (request.getParameter("limpaBusca") != null) {
            session.setAttribute("SEARCH", "0");
            session.setAttribute("ORDER", "1");
            session.setAttribute("ORDER2", " ASC");
            response.sendRedirect("http://localhost:8080/IRotas/administracao.jsp?page=1");
        }

    } catch (Exception ex) {
        admException = ex.getMessage();
    }
%>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" href="images/Logo2.png">
        <title>Administra��o</title>
        <%@include file="WEB-INF/jspf/css.jspf" %>
        <%@include file="WEB-INF/jspf/scripts.jspf" %>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <%if (session.getAttribute("user") == null) {%>
        <%} else {%> 
        <%if (((User) session.getAttribute("user")).getAdministrator() == 0) {%>
        <%out.print("Voc� deve ser administrador para acessar o conte�do desta p�gina");%>
        <%} else {%>
        <div class="container-fluid" justify-content: center;">
            <div class="row justify-content-center">
                <div class="col-10">
                    <div class="caixa" style="margin-top: 30px;">
                        <h1 style="padding-bottom: 5px;">Lista de Alunos</h1>
                        <%if (admException != null) {%>
                        <div style="color: black; font-size: 30px; border: 10px double red;">
                            <% out.print(admException);%>
                        </div>
                        <br>
                        <%}%>
                        <form autocomplete="off" method="POST">
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="inputGroup">Buscar por:</span>
                                <input class="form-control" type="text" name="search" placeholder="Nome do Usu�rio" required>
                                <input type="submit" name="searchCli" value="Buscar" class="btn btn-primary"/>
                            </div>
                        </form>
                        <table class="table table-my table-bordered" style="">
                            <thead>
                                <tr class="table-my">
                            <form autocomplete="off" method="POST">
                                <th><input class="orderADM" type="submit" name="orderCliId" value="ID"/></th>
                                <th><input class="orderADM" type="submit" name="orderCliAdm" value="Adiministrador"/></th>
                                <th><input class="orderADM" type="submit" name="orderCliNome" value="Nome"/></th>
                                <th><input class="orderADM" type="submit" name="orderCliSnome" value="Sobrenome"/></th>
                                <th><input class="orderADM" type="submit" name="orderCliEmail" value="E-mail"/></th>
                                <th><input class="orderADM" type="submit" name="orderCliTele" value="Telefone"/></th>
                                <th><input class="orderADM" type="submit" name="orderCliNasci" value="Data de Nascimento"/></th>
                                <th><input class="orderADM" type="submit" name="orderCliSexo" value="Sexo"/></th>
                                <th>A��es</th>
                            </form>
                            </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (session.getAttribute("SEARCH").toString().equals("0")) {
                                        for (User u : users) {%>
                                <tr class="table-my">
                                    <td><%= u.getIdCLiente()%></td>
                                    <td><% if (u.getAdministrator() == 1) {
                                            out.print("Sim");
                                        } else {
                                            out.print("N�o");
                                        }%></td>
                                    <td><%= u.getNome()%></td>
                                    <td><%= u.getSobrenome()%></td>
                                    <td><%= u.getEmail()%></td>
                                    <td><%= u.getTelefone()%></td>
                                    <td><% String strNor = u.getDataNascimento().toString();
                                        String strCorreta = "";
                                        String dia = "";
                                        String mes = "";
                                        String ano = "";
                                        for (int i = 0; i < strNor.length(); i++) {
                                            if (i <= 3) {
                                                ano += strNor.charAt(i);

                                            } else if (i == 4) {
                                                mes += '/';
                                            } else if (i >= 5 && i <= 6) {
                                                mes += strNor.charAt(i);

                                            } else if (i == 7) {
                                                mes += '/';
                                            } else {
                                                dia += strNor.charAt(i);
                                            }

                                        }
                                        strCorreta = dia + mes + ano;

                                        out.print(strCorreta);%></td>
                                    <td><% if (u.getSexo() == 'M') {
                                            out.print("Masculino");
                                        } else {
                                            out.print("Feminino");
                                        }%></td>
                                    <td>
                                        <form autocomplete="off" method="POST">
                                            <button class="btn btn-warning" style="color: white;">
                                                <a class="nav-link navLog" data-bs-toggle="modal" data-bs-target="#altCliente"
                                                   onclick="setaDataCli('<%= u.getIdCLiente()%>', '<%= u.getNome()%>', '<%= u.getSobrenome()%>',
                                                                   '<%= u.getEmail()%>', '<%= u.getTelefone()%>', '<%= u.getDataNascimento().toString()%>')"> <b>Alterar</b></a>
                                            </button>
                                            <button class="btn btn-primary" style="color: white;">
                                                <a class="nav-link navLog" data-bs-toggle="modal" data-bs-target="#altSenha"
                                                   onclick="setaIdSenha('<%= u.getIdCLiente()%>')"><b>Alterar Senha</b></a>
                                            </button>
                                            <input type="hidden" name="idenCliDel" value="<%= u.getIdCLiente()%>" />
                                            <input style="font-weight: bold;" type="submit" name="delCli" value="Remover" class="btn btn-danger"/>
                                        </form>
                                    </td>
                                </tr>
                                <%}
                                } else {
                                    for (User u : userSearch) {%>
                                <tr class="table-my">
                                    <td><%= u.getIdCLiente()%></td>
                                    <td><% if (u.getAdministrator() == 1) {
                                            out.print("Sim");
                                        } else {
                                            out.print("N�o");
                                        }%></td>
                                    <td><%= u.getNome()%></td>
                                    <td><%= u.getSobrenome()%></td>
                                    <td><%= u.getEmail()%></td>
                                    <td><%= u.getTelefone()%></td>
                                    <td><% String strNor = u.getDataNascimento().toString();
                                        String strCorreta = "";
                                        String dia = "";
                                        String mes = "";
                                        String ano = "";
                                        for (int i = 0; i < strNor.length(); i++) {
                                            if (i <= 3) {
                                                ano += strNor.charAt(i);

                                            } else if (i == 4) {
                                                mes += '/';
                                            } else if (i >= 5 && i <= 6) {
                                                mes += strNor.charAt(i);

                                            } else if (i == 7) {
                                                mes += '/';
                                            } else {
                                                dia += strNor.charAt(i);
                                            }

                                        }
                                        strCorreta = dia + mes + ano;

                                        out.print(strCorreta);%></td>
                                    <td><% if (u.getSexo() == 'M') {
                                            out.print("Masculino");
                                        } else {
                                            out.print("Feminino");
                                        }%></td>
                                    <td>
                                        <form autocomplete="off" method="POST">
                                            <button class="btn btn-warning" style="color: white;">
                                                <a class="nav-link navLog" data-bs-toggle="modal" data-bs-target="#altCliente"
                                                   onclick="setaDataCli('<%= u.getIdCLiente()%>', '<%= u.getNome()%>', '<%= u.getSobrenome()%>',
                                                                   '<%= u.getEmail()%>', '<%= u.getTelefone()%>', '<%= u.getDataNascimento().toString()%>')"> <b>Alterar</b></a>
                                            </button>
                                            <button class="btn btn-primary" style="color: white;">
                                                <a class="nav-link navLog" data-bs-toggle="modal" data-bs-target="#altSenha"
                                                   onclick="setaIdSenha('<%= u.getIdCLiente()%>')"><b>Alterar Senha</b></a>
                                            </button>
                                            <input type="hidden" name="idenCliDel" value="<%= u.getIdCLiente()%>" />
                                            <input style="font-weight: bold;" type="submit" name="delCli" value="Remover" class="btn btn-danger"/>
                                        </form>
                                    </td>
                                </tr>
                                <%}
                                    }%>
                            </tbody>
                        </table>
                        <!--Modal de Altera��o de Dados de Usu�rios-->
                        <div class="modal fade" style="color: black" id="altCliente" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl text-center">
                                <div class="modal-content">
                                    <div class="modal-body">                    
                                        <h4 class="modal-title" id="exampleModalLabel" style="margin: auto;">Alterar Aluno</h4><hr>
                                        <div class="row">
                                            <form autocomplete="off" method="POST">
                                                <input class="form-control" type="hidden" name="id" id="idenCli">
                                                <div class="row">
                                                    <div class="input-group mb-3">
                                                        <span class="input-group-text" id="inputGroup">Administrador</span>
                                                        <select class="form-select" name="adm" required>
                                                            <option value="1">Sim</option>
                                                            <option value="0">N�o</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col">
                                                    <input class="form-control" type="text" name="nome" id="nome" placeholder="Primeiro Nome" required>
                                                    <br><br>
                                                    <input class="form-control" type="email" name="e-mail" id="e-mail" placeholder="E-mail" required>
                                                    <br><br>
                                                    <input class="form-control" type="text" name="phone" id="phone"  placeholder="Telefone Celular Ex: (xx)xxxxx-xxxx"
                                                           pattern="[(]{1}[0-9]{2}[)]{1}[0-9]{5}[-]{1}[0-9]{4}"
                                                           title="N�emro do telefone celular Ex: (xx)xxxxx-xxxx" required>
                                                </div>
                                                <div class="col">
                                                    <input class="form-control" type="text" name="sobrenome" id="sobrenome" placeholder="Sobrenome" required>
                                                    <br><br>
                                                    <div class="row" style="height: 38px;">
                                                        <div class="col">
                                                            <input class="form-control" type="date" name="bDate" id="bDate" placeholder="Data de Nascimento" required>
                                                        </div>
                                                        <div class="col">
                                                            <div class="input-group mb-3">
                                                                <span class="input-group-text" id="inputGroup">Sexo</span>
                                                                <select class="form-select" name="sex" required>
                                                                    <option value="M">Masculino</option>
                                                                    <option value="F">Feminino</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row" style="margin-top: 20px;">
                                                    <div class="col-2-center">
                                                        <input type="submit" name="altCli" value="Salvar Altera��es" class="btn btn-primary" style="margin-right: 20%">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>      
                                                        </form>
                                                    </div>
                                                </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--Modal de Cadastro de Usu�rios-->
                        <div class="modal fade" style="color: black" id="cadCliente" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg text-center">
                                <div class="modal-content">
                                    <div class="modal-body">                    
                                        <h4 class="modal-title" id="exampleModalLabel" style="margin: auto;">Cadastrar Aluno</h4><hr>
                                        <form autocomplete="off" method="POST">
                                            <input class="form-control" type="hidden" name="id" value="1">
                                            <div class="row">
                                                <input class="form-control" style="margin-bottom: 10px;" type="text" name="nome" placeholder="Nome" required>

                                                <input class="form-control" style="margin-bottom: 10px;" type="text" name="sobrenome" placeholder="Sobrenome" required>

                                                <input class="form-control" style="margin-bottom: 10px;" type="email" name="email" placeholder="E-mail" required>
                                            </div>
                                            <div class="row">
                                                <div class="col" style="padding-left: 0px;">
                                                    <input class="form-control" type="text" name="phone" placeholder="Telefone Celular Ex: (xx)xxxxx-xxxx"
                                                           pattern="[(]{1}[0-9]{2}[)]{1}[0-9]{5}[-]{1}[0-9]{4}"
                                                           title="N�emro do telefone celular Ex: (xx)xxxxx-xxxx" required>
                                                </div>
                                                <div class="col" style="padding-right: 0px;">
                                                    <div class="input-group mb-3">
                                                        <span class="input-group-text" id="inputGroup">Sexo</span>
                                                        <select class="form-select" name="sex" required>
                                                            <option value="M">Masculino</option>
                                                            <option value="F">Feminino</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <input class="form-control" style="margin-bottom: 10px;" type="date" name="bDate" placeholder="Data de Nascimento" required>
                                            </div>
                                            <div class="row">
                                                <div class="col" style="padding-left: 0px;">
                                                    <input class="form-control" type="password" name="password" placeholder="Senha" required>
                                                </div>
                                                <div class="col" style="padding-right: 0px;">
                                                    <input class="form-control" type="password" name="pass2" placeholder="Confirmar Senha" required>
                                                </div>
                                            </div>
                                            <hr>
                                            <input class="btn btn-primary" type="submit" name="cadCli" value="Registrar">
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--Modal de Altera��o de Senha de Usu�rios-->
                        <div class="modal fade" style="color: black" id="altSenha" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-sm text-center">
                                <div class="modal-content">
                                    <div class="modal-body">                    
                                        <h4 class="modal-title" id="exampleModalLabel" style="margin: auto;">Alterar Senha</h4><hr>
                                        <form method="post">
                                            <input class="form-control" type="hidden" name="id" id="idenCliSenha">
                                            <div class="mb-3">
                                                <label for="password" class="form-label">Senha Nova</label>
                                                <input name="passNew1" type="password" class="form-control" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="password" class="form-label">Senha Nova - Confirma��o</label>
                                                <input name="passNew2" type="password" class="form-control" required>
                                            </div>
                                            <hr>
                                            <div class="container" style="margin: auto;">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                                <button name="altSenha" type="submit" class="btn btn-primary" type="submit">Confirmar</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div style="display: inline-flex">
                            <button class="btn btn-primary" style="color: white;">
                                <a class="nav-link navLog" data-bs-toggle="modal" data-bs-target="#cadCliente"><b>Cadastrar</b></a>
                            </button>
                            <%if (session.getAttribute("SEARCH").toString().equals("0")) {
                                } else {%>
                            <form autocomplete="off" method="POST">
                                <input type="submit" name="limpaBusca" value="Limpar Busca" class="btn btn-dark" style="margin-left: 20px"/>
                            </form>
                            <%}%>
                        </div>
                    </div>
                </div>
                <div>
                    <a style="text-decoration: none; font-size: 30px; margin-right: 18%; <% if (Integer.parseInt(request.getParameter("page")) == 1) {
                            out.print(" color: grey; cursor: not-allowed; opacity: 0.5; pointer-events: none;");
                        }%>" href="administracao.jsp?page=<%= Integer.parseInt(request.getParameter("page")) - 1%>"><</a>
                    <a style="text-decoration: none; font-size: 30px; margin-right: 10%;" href="administracao.jsp?page=1">1</a>
                    <a style="text-decoration: none; font-size: 30px; margin-right: 10%; <% if (total < 6) {
                            out.print(" color: grey; cursor: not-allowed; opacity: 0.5; pointer-events: none;");
                        }%>" href="administracao.jsp?page=2">2</a>
                    <a style="text-decoration: none; font-size: 30px; margin-right: 10%; <% if (total < 11) {
                            out.print(" color: grey; cursor: not-allowed; opacity: 0.5; pointer-events: none;");
                        }%>" href="administracao.jsp?page=3">3</a>
                    <a style="text-decoration: none; font-size: 30px; margin-right: 10%; <% if (total < 16) {
                            out.print(" color: grey; cursor: not-allowed; opacity: 0.5; pointer-events: none;");
                        }%>" href="administracao.jsp?page=4">4</a>
                    <a style="text-decoration: none; font-size: 30px; margin-right: 17%; <% if (total < 21) {
                            out.print(" color: grey; cursor: not-allowed; opacity: 0.5; pointer-events: none;");
                        }%>" href="administracao.jsp?page=5">5</a>
                    <a style="text-decoration: none; font-size: 30px; <% if (total < 6) {
                            out.print(" color: grey; cursor: not-allowed; opacity: 0.5; pointer-events: none;");
                        }%>" href="administracao.jsp?page=<%=Integer.parseInt(request.getParameter("page")) + 1%>">></a>
                </div>
            </div>
        </div>  
        <%}%>
        <%}%>
        <%@include file="WEB-INF/jspf/footer.jspf" %>
        <script>
            function setaDataCli(id, nome, sobrenome, email, telefone, bDate) {
                document.getElementById('idenCli').value = id;
                document.getElementById('nome').value = nome;
                document.getElementById('sobrenome').value = sobrenome;
                document.getElementById('e-mail').value = email;
                document.getElementById('phone').value = telefone;
                document.getElementById('bDate').value = bDate;
            }

            function setaIdSenha(id) {
                document.getElementById('idenCliSenha').value = id;
            }
        </script>
    </body>
</html>