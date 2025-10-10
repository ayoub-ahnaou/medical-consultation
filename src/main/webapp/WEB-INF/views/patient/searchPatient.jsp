<div class="bg-white rounded-xl shadow-md p-6">
    <h2 class="text-xl font-semibold text-blue-700 mb-4 flex items-center">
        <i class="fas fa-search mr-2"></i>Rechercher un patient
    </h2>

    <form action="${pageContext.request.contextPath}/searchPatient" method="get" class="mb-6">
        <div class="flex">
            <input type="text" name="name" placeholder="Nom et Prenom du patient (e.g: Ayoub Ahnaou)" required
                   value="${fn:escapeXml(param.name)}"
                   class="flex-grow px-4 py-2 border border-gray-300 rounded-l-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            <button type="submit"
                    class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-r-lg transition duration-200 flex items-center">
                <i class="fas fa-search mr-2"></i>Rechercher
            </button>
        </div>
    </form>

    <!-- Only show results after a search -->
    <c:if test="${not empty param.name}">
        <!-- Patient Found -->
        <c:if test="${not empty patient}">
            <div class="bg-green-50 border-l-4 border-green-500 p-4 rounded-lg mb-4">
                <h3 class="text-lg font-medium text-green-800 mb-2">Patient trouvé :</h3>
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-700 font-medium">${patient.firstName} ${patient.lastName}</p>
                        <p class="text-sm text-gray-500">ID: ${patient.id}</p>
                    </div>
                    <form action="${pageContext.request.contextPath}/addMedicaleFile" method="get">
                        <input type="hidden" name="patientId" value="${patient.id}">
                        <button type="submit"
                                class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-lg transition duration-200 flex items-center">
                            <i class="fas fa-file-medical mr-2"></i>Créer un dossier médical
                        </button>
                    </form>
                </div>
            </div>
        </c:if>

        <!-- No Patient Found -->
        <c:if test="${empty patient}">
            <div class="bg-yellow-50 border-l-4 border-yellow-500 p-4 rounded-lg">
                <p class="text-yellow-700 mb-2">Aucun patient trouvé avec ce nom.</p>
                <a href="${pageContext.request.contextPath}/addPatient"
                   class="text-blue-600 hover:text-blue-800 font-medium flex items-center">
                    <i class="fas fa-user-plus mr-2"></i>Créer un nouveau patient
                </a>
            </div>
        </c:if>
    </c:if>
</div>
