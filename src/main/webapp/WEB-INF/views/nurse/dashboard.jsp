<%@ include file="../layout/header.jsp" %>

<%--<h1>Welcome, Nurse!</h1>--%>
<%--<p>This is your dashboard. You can view and manage patient information here.</p>--%>
<%--<%@include file="../patient/searchPatient.jsp" %>--%>
<%--<%@include file="../ticket/ticketsList.jsp" %>--%>

<%--<%@ include file="../layout/footer.jsp" %>--%>

<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <%-- rechercher un patient--%>
    <div class="font-semibold text-blue-700 mb-4 flex items-center justify-between py-2">
        <p class="text-xl">Rechercher un patient</p>

        <a href="${pageContext.request.contextPath}/addPatient"
           class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-r-lg transition duration-200 flex items-center">
            <p>Créer un nouveau patient</p>
        </a>
    </div>

    <form action="${pageContext.request.contextPath}/searchPatient" method="get" class="mb-6">
        <div class="flex">
            <input type="text" name="name" placeholder="Nom et Prenom du patient (e.g: Ayoub Ahnaou)" required
                   value="${fn:escapeXml(param.name)}"
                   class="flex-grow px-4 py-2 border border-gray-300 rounded-l-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            <button type="submit"
                    class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-r-lg transition duration-200 flex items-center">
                Rechercher
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

    <!-- Patients List -->
    <div class="bg-white rounded-lg shadow overflow-hidden">
        <div class="px-6 py-4 border-b border-gray-200">
            <h2 class="text-lg font-semibold text-gray-900">Liste des Patients Enregistrés</h2>
            <p class="text-sm text-gray-600 mt-1">Patients du jour - Triés par heure d'arrivée</p>
        </div>

        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Patient</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">N° Sécurité Sociale</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Heure d'arrivée</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Signes Vitaux</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Statut</th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <tr class="hover:bg-gray-50">
                    <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm font-medium text-gray-900">Ahmed Bennani</div>
                        <div class="text-sm text-gray-500">45 ans</div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">1 85 03 75 123 456</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">08:15</td>
                    <td class="px-6 py-4">
                        <div class="text-xs space-y-1">
                            <div><span class="font-medium">TA:</span> 120/80 mmHg</div>
                            <div><span class="font-medium">FC:</span> 72 bpm</div>
                            <div><span class="font-medium">Temp:</span> 36.8°C</div>
                        </div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                    En attente
                                </span>
                    </td>
                </tr>
                <tr class="hover:bg-gray-50">
                    <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm font-medium text-gray-900">Fatima El Amrani</div>
                        <div class="text-sm text-gray-500">32 ans</div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">2 90 06 15 234 567</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">08:30</td>
                    <td class="px-6 py-4">
                        <div class="text-xs space-y-1">
                            <div><span class="font-medium">TA:</span> 115/75 mmHg</div>
                            <div><span class="font-medium">FC:</span> 68 bpm</div>
                            <div><span class="font-medium">Temp:</span> 37.2°C</div>
                        </div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                    En attente
                                </span>
                    </td>
                </tr>
                <tr class="hover:bg-gray-50">
                    <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm font-medium text-gray-900">Mohammed Kadiri</div>
                        <div class="text-sm text-gray-500">58 ans</div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">1 67 01 20 345 678</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">08:45</td>
                    <td class="px-6 py-4">
                        <div class="text-xs space-y-1">
                            <div><span class="font-medium">TA:</span> 140/90 mmHg</div>
                            <div><span class="font-medium">FC:</span> 85 bpm</div>
                            <div><span class="font-medium">Temp:</span> 36.5°C</div>
                        </div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                    En attente
                                </span>
                    </td>
                </tr>
                <tr class="hover:bg-gray-50">
                    <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm font-medium text-gray-900">Samira Benjelloun</div>
                        <div class="text-sm text-gray-500">27 ans</div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">2 98 04 10 456 789</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">09:00</td>
                    <td class="px-6 py-4">
                        <div class="text-xs space-y-1">
                            <div><span class="font-medium">TA:</span> 110/70 mmHg</div>
                            <div><span class="font-medium">FC:</span> 65 bpm</div>
                            <div><span class="font-medium">Temp:</span> 36.9°C</div>
                        </div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                    En consultation
                                </span>
                    </td>
                </tr>
                <tr class="hover:bg-gray-50">
                    <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm font-medium text-gray-900">Youssef Alami</div>
                        <div class="text-sm text-gray-500">51 ans</div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">1 72 08 18 567 890</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">09:15</td>
                    <td class="px-6 py-4">
                        <div class="text-xs space-y-1">
                            <div><span class="font-medium">TA:</span> 125/82 mmHg</div>
                            <div><span class="font-medium">FC:</span> 78 bpm</div>
                            <div><span class="font-medium">Temp:</span> 37.0°C</div>
                        </div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                    En attente
                                </span>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal for New Patient -->
<div id="patientModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
    <div class="relative top-20 mx-auto p-5 border w-full max-w-3xl shadow-lg rounded-md bg-white">
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-xl font-semibold text-gray-900">Accueil Patient</h3>
            <button onclick="closeModal()" class="text-gray-400 hover:text-gray-600">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </button>
        </div>

        <!-- Search Patient Section -->
        <div class="mb-6 p-4 bg-blue-50 rounded-lg">
            <label class="block text-sm font-medium text-gray-700 mb-2">Rechercher un patient existant</label>
            <div class="flex gap-2">
                <input type="text" placeholder="N° Sécurité Sociale ou Nom" class="flex-1 px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                <button class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-lg font-medium transition">
                    Rechercher
                </button>
            </div>
        </div>

        <form class="space-y-6">
            <!-- Personal Information -->
            <div class="border-b border-gray-200 pb-6">
                <h4 class="text-lg font-medium text-gray-900 mb-4">Informations Personnelles</h4>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Nom *</label>
                        <input type="text" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Prénom *</label>
                        <input type="text" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Date de naissance *</label>
                        <input type="date" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">N° Sécurité Sociale *</label>
                        <input type="text" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Téléphone</label>
                        <input type="tel" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Adresse</label>
                        <input type="text" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                </div>
            </div>

            <!-- Vital Signs -->
            <div>
                <h4 class="text-lg font-medium text-gray-900 mb-4">Signes Vitaux</h4>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Tension Artérielle *</label>
                        <input type="text" placeholder="120/80" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Fréquence Cardiaque *</label>
                        <input type="number" placeholder="72 bpm" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Température (°C) *</label>
                        <input type="number" step="0.1" placeholder="36.8" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Fréquence Respiratoire *</label>
                        <input type="number" placeholder="16 /min" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Poids (kg)</label>
                        <input type="number" step="0.1" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Taille (cm)</label>
                        <input type="number" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                </div>
            </div>

            <!-- Medical Information -->
            <div>
                <h4 class="text-lg font-medium text-gray-900 mb-4">Informations Médicales</h4>
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Antécédents médicaux</label>
                        <textarea rows="2" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"></textarea>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Allergies</label>
                        <textarea rows="2" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"></textarea>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Traitements en cours</label>
                        <textarea rows="2" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"></textarea>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex justify-end gap-3 pt-4 border-t border-gray-200">
                <button type="button" onclick="closeModal()" class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 font-medium transition">
                    Annuler
                </button>
                <button type="submit" class="px-6 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg font-medium transition">
                    Enregistrer et Ajouter à la File d'Attente
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    function showModal() {
        document.getElementById('patientModal').classList.remove('hidden');
    }

    function closeModal() {
        document.getElementById('patientModal').classList.add('hidden');
    }

    function logout() {
        if(confirm('Êtes-vous sûr de vouloir vous déconnecter?')) {
            window.location.href = 'login.jsp';
        }
    }

    // Close modal when clicking outside
    document.getElementById('patientModal').addEventListener('click', function(e) {
        if(e.target === this) {
            closeModal();
        }
    });
</script>
</body>
</html>
