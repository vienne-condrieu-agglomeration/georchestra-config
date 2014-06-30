<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="org.georchestra._header.Utf8ResourceBundle" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%
Boolean anonymous = true;
Boolean admin= false;

/*
response.setDateHeader("Expires", 31536000);
response.setHeader("Cache-Control", "private, max-age=31536000");
*/

// to prevent problems with proxies, and for now:
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies.

String active = request.getParameter("active");
if (active == null) {
    active = "none";
}

String lang = request.getParameter("lang");
if (lang == null || (!lang.equals("en") && !lang.equals("es") && !lang.equals("ru") && !lang.equals("fr"))) {
    lang = "fr";
}
Locale l = new Locale(lang);
ResourceBundle resource = org.georchestra._header.Utf8ResourceBundle.getBundle("_header.i18n.index",l);
javax.servlet.jsp.jstl.core.Config.set(
    request,
    javax.servlet.jsp.jstl.core.Config.FMT_LOCALIZATION_CONTEXT,
    new javax.servlet.jsp.jstl.fmt.LocalizationContext(resource)
);

String sec_roles = request.getHeader("sec-roles");
if(sec_roles != null) {
    String[] roles = sec_roles.split(",");
    for (int i = 0; i < roles.length; i++) {
        // ROLE_ANONYMOUS is added by the security proxy:
        if (roles[i].equals("ROLE_ANONYMOUS")) {
            //response.setHeader("Cache-Control", "public, max-age=31536000");
            break;
        }
        if (roles[i].equals("ROLE_SV_EDITOR") || roles[i].equals("ROLE_SV_REVIEWER") || roles[i].equals("ROLE_SV_ADMIN") || roles[i].equals("ROLE_SV_ADMINISTRATOR") || roles[i].equals("ROLE_SV_USER")) {
            anonymous = false;
        }
        if (roles[i].equals("ROLE_SV_ADMIN") || roles[i].equals("ROLE_SV_ADMINISTRATOR")) {
            admin = true;
        }
    }
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet"/>
    <link href="bootstrap/css/mystyle.css" rel="stylesheet"/>
</head>


<body>
    <div class="container">
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
            <a href="#" class="navbar-brand hidden-xs" title="<fmt:message key='go.home'/>">
                <img src="img/logo-tr.png" alt="<fmt:message key='logo'/>" height="40"/>
            </a>
            <a href="#" class="navbar-brand visible-xs" title="<fmt:message key='go.home'/>">
                <img src="img/logo-xs.png" alt="<fmt:message key='logo'/>" height="40"/>
            </a>
            <div class="hidden-xs">
                <ul class="nav navbar-nav menu">
                    <c:choose>
                        <c:when test='<%= active.equals("Accueil") %>'>
                            <li class="active"><a href="/geoserver/web/">Accueil</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="../">Accueil</a></li>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test='<%= active.equals("geonetwork") %>'>
                            <li class="active"><a href="/geonetwork/apps/georchestra/"><fmt:message key="catalogue"/></a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="/geonetwork/apps/georchestra/"><fmt:message key="catalogue"/></a></li>
                        </c:otherwise>
                    </c:choose>
                
                    <c:choose>
                        <c:when test='<%= active.equals("mapfishapp") %>'>
                            <li class="active"><a><fmt:message key="viewer"/></a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="/mapfishapp/"><fmt:message key="viewer"/></a></li>
                        </c:otherwise>
                    </c:choose>
                
                    <c:choose>
                        <c:when test='<%= active.equals("extractorapp") %>'>
                        <li class="active"><a><fmt:message key="extractor"/></a></li>
                        </c:when>
                        <c:otherwise>
                        <li><a href="/extractorapp/"><fmt:message key="extractor"/></a></li>
                        </c:otherwise>
                    </c:choose>
        
                    <c:choose>
                        <c:when test='<%= admin == true %>'>
                            <c:choose>
                                <c:when test='<%= active.equals("geoserver") %>'>
                                    <li class="active"><a href="/geoserver/web/"><fmt:message key="services"/></a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="/geoserver/web/"><fmt:message key="services"/></a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test='<%= admin == true %>'>
                            <li id="reload"><a><span class="glyphicon glyphicon-refresh"></span></a></li>
                        </c:when>
                    </c:choose>
                </ul> <!--menu-->
                <ul class="nav navbar-nav login">
                <c:choose>
                    <c:when test='<%= anonymous == false %>'>
                        <p class="navbar-text navbar-right">
                            <a href="/ldapadmin/account/userdetails"><%=request.getHeader("sec-username") %></a> | 
                            <a href="/j_spring_security_logout"><fmt:message key="logout"/></a>
                        </p>
                    </c:when>
                    <c:otherwise>
                        <p class="navbar-text navbar-right">
                            <a id="login_a"><fmt:message key="login"/></a>
                        </p>
                    </c:otherwise>
                </c:choose>
                </ul> <!--login-->
            </div> <!--hidden-xs-->
            <div class="visible-xs">
                <ul class="nav navbar-nav">
                    <c:choose>
                        <c:when test='<%= active.equals("Accueil") %>'>
                            <li class="active"><a href="/geoserver/web/"><span class="glyphicon glyphicon-home"></span></a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="../"><span class="glyphicon glyphicon-home"></span></a></li>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test='<%= active.equals("geonetwork") %>'>
                            <li class="active"><a href="/geonetwork/apps/georchestra/"><span class="glyphicon glyphicon-search"></span></a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="/geonetwork/apps/georchestra/"><span class="glyphicon glyphicon-search"></span></a></li>
                        </c:otherwise>
                    </c:choose>
                
                    <c:choose>
                        <c:when test='<%= active.equals("mapfishapp") %>'>
                            <li class="active"><a><span class="glyphicon glyphicon-globe"></span></a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="/mapfishapp/"><span class="glyphicon glyphicon-globe"></span></a></li>
                        </c:otherwise>
                    </c:choose>
                
                    <c:choose>
                        <c:when test='<%= active.equals("extractorapp") %>'>
                        <li class="active"><a><span class="glyphicon glyphicon-download-alt"></span></a></li>
                        </c:when>
                        <c:otherwise>
                        <li><a href="/extractorapp/"><span class="glyphicon glyphicon-download-alt"></span></a></li>
                        </c:otherwise>
                    </c:choose>
        
                    <c:choose>
                        <c:when test='<%= admin == true %>'>
                            <c:choose>
                                <c:when test='<%= active.equals("geoserver") %>'>
                                    <li class="active"><a href="/geoserver/web/"><span class="glyphicon glyphicon-wrench"></span></a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="/geoserver/web/"><span class="glyphicon glyphicon-wrench"></span></a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                    </c:choose> 
                    <div class="loginb">
                        <c:choose>
                            <c:when test='<%= anonymous == false %>'>
                                <p class="navbar-text navbar-right">
                                    <a href="/ldapadmin/account/userdetails"><%=request.getHeader("sec-username") %></a> | 
                                    <a href="/j_spring_security_logout"><fmt:message key="logout"/></a>
                                </p>
                            </c:when>
                            <c:otherwise>
                                <p class="navbar-text navbar-right">
                                    <a id="login_a"><fmt:message key="login"/></a>
                                </p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </ul>
            </div> <!--visible-xs-->
        </nav> <!--nav-->
    </div><!-- container-->

    <script>
        (function(){
            // required to get the correct redirect after login, see https://github.com/georchestra/georchestra/issues/170
            var url,
                a = document.getElementById("login_a");
            if (a !== null) {
                url = parent.window.location.href;
                if (/\/cas\//.test(url)) {
                    a.href = "/cas/login";
                } else {
                    /* Taken from https://github.com/openlayers/openlayers/blob/master/lib/OpenLayers/Util.js#L557 */
                    var paramStr="login", parts = (url + " ").split(/[?&]/);
                    a.href = url + (parts.pop() === " " ?
                        paramStr :
                        parts.length ? "&" + paramStr : "?" + paramStr);
                }
            }

            // handle menus
            if (!window.addEventListener || !document.querySelectorAll) return;
            var each = function(els, callback) {
                for (var i = 0, l=els.length ; i<l ; i++) {
                    callback(els[i]);
                }
            }
            each(document.querySelectorAll('#go_head li a'), function(li){
                li.addEventListener('click', function(e) {
                    each(
                        document.querySelectorAll('#go_head li'),
                        function(l){ l.className = '';}
                    );
                    li.parentNode.className = 'active';
                });
            });
        })();
    </script>
    <script type="text/javascript" src="bootstrap/js/jquery.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/myscript.js"></script>
    <script type="text/javascript">


    $(document).ready(function () {
        $("#reload").click(function() {
            $.ajax("/scripts/reload.py")
            .done(function(response) {
                //alert(data);
                var json = jQuery.parseJSON(response);
                $(".menu").append('<li id="fade"><span class="btn '+json.style+'">'+json.message+'</span></li>');
                $("#fade").delay(2000).fadeOut("slow");
            })        
        });
    });
   
    </script>

    

</body>
</html>
