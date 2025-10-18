<%@ include file="../layout/header.jsp" %>

<!-- Main Content -->
<div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <!-- Back Button -->
    <div class="mb-6">
        <a href="${pageContext.request.contextPath}/dashboard"
           class="text-blue-600 hover:text-blue-700 flex items-center gap-2 font-medium">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
            </svg>
            Retour au tableau de bord
        </a>
    </div>

    <!-- Error Message -->
    <c:if test="${not empty param.error}">
        <div class="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg">
            <p class="text-red-800">${param.error}</p>
        </div>
    </c:if>

    <!-- Page Title -->
    <h1 class="text-3xl font-bold text-gray-900 mb-8">Répondre à la Demande d'Expertise</h1>

    <!-- Main Card -->
    <div class="bg-white rounded-lg shadow-lg overflow-hidden">
        <div class="p-8 space-y-8">

            <!-- Patient Information Section -->
            <div class="bg-blue-50 p-6 rounded-lg border border-blue-200">
                <h2 class="text-xl font-semibold text-gray-900 mb-6">Informations du Patient</h2>
                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <p class="text-sm font-medium text-gray-600 mb-1">Patient:</p>
                        <c:set var="now" value="<%= java.time.LocalDate.now() %>"/>
                        <c:set var="birthDate" value="${patient.dateOfBirth}"/>
                        <c:set var="age"
                               value="${now.year - birthDate.year - ((now.monthValue > birthDate.monthValue || (now.monthValue == birthDate.monthValue && now.dayOfMonth >= birthDate.dayOfMonth)) ? 0 : 1)}"/>
                        <p class="text-lg font-semibold text-gray-900">
                            ${patient.firstName} ${patient.lastName}, ${age} ans
                        </p>
                    </div>
                    <div>
                        <p class="text-sm font-medium text-gray-600 mb-1">Médecin Généraliste:</p>
                        <p class="text-lg font-semibold text-gray-900">
                            Dr. ${generalist.lastName} ${generalist.firstName}
                        </p>
                    </div>
                    <div>
                        <p class="text-sm font-medium text-gray-600 mb-1">Date de la Demande:</p>
                        <p class="text-lg font-semibold text-gray-900">
                            <fmt:formatDate value="${expertiseRequest.createdAt}" pattern="dd/MM/yyyy"/> à
                            <fmt:formatDate value="${expertiseRequest.createdAt}" pattern="HH:mm"/>
                        </p>
                    </div>
                    <div>
                        <p class="text-sm font-medium text-gray-600 mb-1">Créneau Proposé:</p>
                        <p class="text-lg font-semibold text-gray-900">
                            <fmt:formatDate value="${expertiseRequest.consultationDate}" pattern="dd/MM/yyyy"/> à
                            <fmt:formatDate value="${expertiseRequest.consultationDate}" pattern="HH:mm"/>
                        </p>
                    </div>
                </div>
            </div>

            <!-- Vital Signs Section -->
            <div class="bg-gray-50 p-6 rounded-lg border border-gray-200">
                <h2 class="text-xl font-semibold text-gray-900 mb-6">Signes Vitaux du Patient</h2>
                <div class="grid grid-cols-3 gap-4">
                    <div class="bg-white p-4 rounded-lg">
                        <p class="text-xs font-medium text-gray-600 mb-2">Température</p>
                        <p class="text-2xl font-bold text-blue-600">${medicaleFile.temperature}°C</p>
                    </div>
                    <div class="bg-white p-4 rounded-lg">
                        <p class="text-xs font-medium text-gray-600 mb-2">Pouls</p>
                        <p class="text-2xl font-bold text-blue-600">${medicaleFile.pulse} bpm</p>
                    </div>
                    <div class="bg-white p-4 rounded-lg">
                        <p class="text-xs font-medium text-gray-600 mb-2">Tension Artérielle</p>
                        <p class="text-2xl font-bold text-blue-600">${medicaleFile.bloodPresure} mmHg</p>
                    </div>
                    <div class="bg-white p-4 rounded-lg">
                        <p class="text-xs font-medium text-gray-600 mb-2">Fréquence Respiratoire</p>
                        <p class="text-2xl font-bold text-blue-600">${medicaleFile.respiratoryRate} cpm</p>
                    </div>
                    <div class="bg-white p-4 rounded-lg">
                        <p class="text-xs font-medium text-gray-600 mb-2">SpO₂</p>
                        <p class="text-2xl font-bold text-blue-600">${medicaleFile.oxygenSaturation}%</p>
                    </div>
                    <div class="bg-white p-4 rounded-lg">
                        <p class="text-xs font-medium text-gray-600 mb-2">Douleur</p>
                        <p class="text-2xl font-bold text-blue-600">${medicaleFile.pain}/10</p>
                    </div>
                </div>
            </div>

            <!-- Question Asked Section -->
            <div class="bg-gray-50 p-6 rounded-lg border border-gray-200">
                <h2 class="text-xl font-semibold text-gray-900 mb-4">Question Posée:</h2>
                <p class="text-gray-700 leading-relaxed">${expertiseRequest.description}</p>
            </div>

            <!-- Medical Acts Section -->
            <c:if test="${not empty consultation.medicaleActs}">
                <div class="bg-blue-50 p-6 rounded-lg border border-blue-200">
                    <h2 class="text-xl font-semibold text-gray-900 mb-4">Actes Médicaux Réalisés:</h2>
                    <div class="flex flex-wrap gap-3">
                        <c:forEach var="act" items="${consultation.medicaleActs}">
                            <span class="inline-flex items-center px-4 py-2 rounded-full bg-blue-100 text-blue-800 text-sm font-medium">
                                ${act.label} - ${act.price} DH
                            </span>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <!-- Response Form -->
            <form action="${pageContext.request.contextPath}/request/respond" method="POST"
                  class="space-y-6 border-t border-gray-200 pt-8">
                <!-- Hidden Fields -->
                <input type="hidden" name="requestId" value="${expertiseRequest.id}">

                <!-- Medical Opinion -->
                <div>
                    <label class="block text-sm font-semibold text-gray-900 mb-3">Votre Avis Médical *</label>
                    <textarea name="medicalOpinion" rows="8" required
                              placeholder="Fournissez votre diagnostic, analyse et conclusions détaillées..."
                              class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent text-gray-900"></textarea>
                    <p class="text-xs text-gray-500 mt-2">Assurez-vous de fournir une analyse complète et détaillée.</p>
                </div>

                <!-- Cost Confirmation -->
                <div class="bg-green-50 p-6 rounded-lg border border-green-200">
                    <div class="flex justify-between items-center mb-3">
                        <span class="text-sm font-medium text-gray-700">Coût de la consultation:</span>
                        <span class="text-3xl font-bold text-green-600">${expertiseRequest.cost} DH</span>
                    </div>
                    <p class="text-xs text-gray-600">Ces honoraires seront versés après validation de votre réponse.</p>
                </div>

                <!-- Action Buttons -->
                <div class="flex justify-between items-center pt-6 border-t border-gray-200">
                    <a href="${pageContext.request.contextPath}/dashboard"
                       class="px-6 py-3 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 font-medium transition">
                        Annuler
                    </a>

                    <div class="flex gap-3">
                        <!-- Accept & Submit Button -->
                        <button type="submit" name="action" value="accept"
                                class="px-6 py-3 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium transition flex items-center gap-2">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M5 13l4 4L19 7"></path>
                            </svg>
                            Envoyer l'Avis
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
