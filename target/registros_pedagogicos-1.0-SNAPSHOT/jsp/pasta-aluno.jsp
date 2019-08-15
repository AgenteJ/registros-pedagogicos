<%-- 
    Document   : home
    Created on : 15/05/2019, 11:54:23
    Author     : Paulo Ribeiro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page import="model.bean.Aluno"%>
<%@page import="java.util.List"%>
<%@page import="model.dao.AlunoDAO"%>
<%@page import="model.dao.GenericDAO"%>
<%@page import="model.bean.Aux"%>
<%@page import="java.util.List"%>
<%@page import="model.bean.Registro"%>
<%@page import="model.dao.RegistroDAO"%>
<%@page import="model.dao.AlunoDAO"%>
<%@page import="model.bean.Aluno"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags -->
        <title>Registros Pedagógicos</title>
        <meta charset="utf-8">  
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.css"/>
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="../css/bootstrap/mdb.css"/>
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/bootstrap/bootstrap-grid.css"/>
        <link rel="stylesheet" href="../css/bootstrap/js/bootstrap.js">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">

    </head>

    <body class="body">
        <jsp:include page="../header.jsp"/>
        <div class="container body">
            <div class="container-fundo">
                <!--Nav Tabs-->
                <ul class="nav nav-tabs nav-justified" role="tablist">
                    <li class="nav-item active">
                        <a href="#registro" class="nav-link active" data-toggle="tab" role="tab">
                            <i class="fas fa-paste fa-lg"></i>
                            Registros
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#desempenho" class="nav-link" data-toggle="tab" role="tab">
                            <i class="fas fa-chart-bar fa-lg"></i>
                            Acompanhamento   
                        </a>
                    </li>
                </ul>

                <div class="tab-content card mb-5 border-0">
                    <%-- Troca a lista de registros pela de cadastro ao clicar em novo registro --%>  
                    <div class="tab-pane fade in show active" id="registro" role="tabpanel">
                        <%
                            Aluno aluno = new Aluno();
                            AlunoDAO alunoDAO = new AlunoDAO();
                            aluno = alunoDAO.findByMatricula(request.getParameter("matricula"));
                        %>
                        <div class="col-12">
                            <br> 
                            <div class="form-row">
                                <div class="col-md-2">
                                    <img src="../imagens/usuario.png" class="img-thumbnail" readonly>
                                </div>

                                <div class="form-row col-md-10">
                                    <div class="form-group col-md-12">
                                        <label for="discente">Discente</label>
                                        <input class="form-control" type="text" id="discente" name="discente" maxlength="12" value="<%=aluno.getNome()%>" placeholder="Nome do discente" readonly>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <label for="nivel">Nivel</label>
                                        <input class="form-control" type="text" id="nivel" name="nivel" placeholder="nivel" value="<%=aluno.getNivel()%>" readonly>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label for="turma">Turma</label>
                                        <input class="form-control" type="text" id="turma" name="turma" placeholder="Turma" value="<%=aluno.getTurma()%>"readonly>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <label for="matricula">Matrícula</label>
                                        <input class="form-control" type="text" id="matricula" name="matricula" placeholder="Matrícula do discente" value="<%=aluno.getMatricula()%>" readonly>
                                    </div>
                                </div>
                                <h3> <a  id="nomeDoAluno" class="text-bold"><%=aluno.getNome()%></a> </h3>
                            </div>

                            <h1 class="border-bottom"></h1>

                            <br><h5>Últimos registros</h5><br>

                            <% RegistroDAO registroDAO = new RegistroDAO();
                                List<Registro> registros = registroDAO.getRegistroByMatricula(request.getParameter("matricula"));

                                for (Registro r : registros) {%>
                            <form action="/registros_pedagogicos/RegistroServlet" method="POST">
                                <div class="form-row">
                                    <div class="card col-md-12">
                                        <div class="card-header">
                                            <nav class="navbar">

                                                <a class="text-grey"> Modificado em: <em> <%= r.getData()%> <i class="far fa-clock"></i> </em></a>


                                                <ul class="nav justify-content-end">
                                                    <li class="nav-item">
                                                        <a class="nav-link icon-blue" data-toggle="modal" data-target="#editar<%= r.getId()%>">
                                                            <i class="fas fa-edit fa-lg"></i> Editar
                                                        </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link" data-toggle="modal" data-target="#excluir<%= r.getId()%>">
                                                            <i class="fas fa-trash fa-lg"></i> Excluir
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </div>
                                        <div class="card-body">
                                            <a class="text-grey"><strong><%= r.getTipoDeOcorrencia()%></strong></a>
                                            <p class="card-text"><%= r.getDescricao()%></p>
                                        </div>
                                    </div>
                                </div>
                                <br>

                                <!-- Modal excluir -->
                                <div class="modal fade" id="excluir<%= r.getId()%>" tabindex="-1" role="dialog" aria-labelledby="TituloModalCentralizado" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5>
                                                    Excluir registro de <a class="text-bold"><%= aluno.getNome()%></a>?
                                                </h5>

                                                <input class="form-control" type="hidden" id="id" name="id" value="<%= r.getId()%>" readonly>
                                                <input class="form-control" type="hidden" id="matricula" name="matricula" value="<%= aluno.getMatricula()%>" readonly>

                                                <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="alert alert-danger" role="alert">
                                                    Tem certeza que deseja excluir este registro?
                                                </div>
                                            </div>
                                            <div class="modal-footer">

                                                <button type="submit" class="btn btn-danger" name="acao" value="confirmar">Confirmar</button>

                                                <button data-dismiss="modal" type="button" class="btn btn-primary">Cancelar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal Editar -->
                                <div id="editar<%= r.getId()%>" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5>
                                                    Editando registro de <a class="text-bold"><%= aluno.getNome()%></a>
                                                </h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Cancelar">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>

                                            <div class="modal-body">
                                                <div class="form-row">
                                                    <div class="card col-md-12">
                                                        <div class="card-header">
                                                            <nav class="navbar">
                                                                <ul class="nav justify-content-start">
                                                                    <li class="nav-item">
                                                                        <input class="form-control" type="date" id="data" name="data" placeholder="digite a nova data" value="<%= r.getData()%>">
                                                                    </li>
                                                                </ul>
                                                            </nav>
                                                        </div>
                                                        <div class="card-body">
                                                            
                                                            <label for="tipoDeOcorrencia">Tipo de ocorrencia</label>
                                                            <select class="form-control col-md-12" id="tipoDeOcorrencia" name="tipoDeOcorrencia">
                                                                <option>Pais</option>
                                                                <option>Professor</option>
                                                                <option>Requerimento</option>
                                                                <option>Servidores</option>
                                                            </select>
                                                            <br>    
                                                            <textarea class="form-control"  rows="5" id="descricao" name="descricao" placeholder="Descrição sobre a ocorrência"><%= r.getDescricao()%></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <%--  --%> 
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-primary" data-dismiss="modal">Alterar</button>
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                            </div>
                                        </div>  
                                    </div>
                                </div>
                            </form>
                            <% }%>
                        </div>
                        <div class="tab-pane fade" id="desempenho" role="tabpanel">
                            <jsp:include page="desempenho.jsp"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../footer.jsp"/>
    </body>
</html>



