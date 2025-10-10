<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tele-Expertise</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
</head>
<body class="bg-gray-100 font-sans flex flex-col justify-between min-h-screen">

<!-- Header -->
<header class="bg-white shadow-md">
    <div class="container mx-auto px-6 py-4 flex items-center justify-between">

        <!-- Logo -->
        <div class="text-2xl font-bold text-blue-600">
            Tele-Expertise
        </div>

        <!-- User Info -->
        <div class="flex items-center space-x-4">
            <span class="text-gray-800 font-medium">
                Bienvenue, ${sessionScope.user != null ? sessionScope.user.lastName : 'Utilisateur'}
            </span>
            <a href="${pageContext.request.contextPath}/logout"
               class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded transition">
                Logout <%-- todo: hide logout button if user no authenticated --%>
            </a>
        </div>
    </div>
</header>

<!-- Main Content -->
<main class="container mx-auto px-6 py-6 flex-grow">