<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tele-Expertise</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans flex flex-col justify-between min-h-screen">

<!-- Header -->
<header class="bg-white shadow-md">
    <div class="container mx-auto px-6 py-4 flex items-center justify-between">

        <!-- Logo -->
        <div class="text-2xl font-bold text-blue-600">
            Tele-Expertise
        </div>

        <!-- Navigation -->
        <nav>
            <ul class="flex space-x-6 text-gray-700 font-medium">
                <li>
                    <a href="${pageContext.request.contextPath}/dashboard"
                       class="hover:text-blue-600 transition-colors">Tableau de Bord</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/consultations"
                       class="hover:text-blue-600 transition-colors">Consultations</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/patients"
                       class="hover:text-blue-600 transition-colors">Patients</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/experts"
                       class="hover:text-blue-600 transition-colors">Experts</a>
                </li>
            </ul>
        </nav>

        <!-- User Info -->
        <div class="flex items-center space-x-4">
            <span class="text-gray-800 font-medium">
                Bienvenue, ${sessionScope.user != null ? sessionScope.user.lastName : 'Utilisateur'}
            </span>
            <a href="${pageContext.request.contextPath}/logout"
               class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded transition">
                Logout
            </a>
        </div>
    </div>
</header>

<!-- Main Content -->
<main class="container mx-auto px-6 py-6 flex-grow">