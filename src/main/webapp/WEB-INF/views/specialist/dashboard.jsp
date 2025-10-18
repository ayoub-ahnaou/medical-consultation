<%@ include file="../layout/header.jsp" %>

<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <c:if test="${not empty error}">
        <div class="fixed top-4 left-1/2 transform -translate-x-1/2 bg-red-100 text-red-600 text-center px-4 py-3 rounded-lg shadow-lg z-50">
                ${error}
        </div>
    </c:if>

    <div class="max-w-7xl mx-auto">
        <!-- Tabs -->
        <div class="mb-6">
            <div class="border-b border-gray-200">
                <nav class="-mb-px flex space-x-8">
                    <button onclick="switchTab('expertises')" id="tab-expertises"
                            class="tab-active border-b-2 border-blue-500 py-4 px-1 text-sm font-medium text-blue-600">
                        Demandes d'Expertise
                    </button>
                    <button onclick="switchTab('schedule')" id="tab-schedule"
                            class="tab-inactive border-b-2 border-transparent py-4 px-1 text-sm font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300">
                        Mes Créneaux
                    </button>
                    <button onclick="switchTab('history')" id="tab-history"
                            class="tab-inactive border-b-2 border-transparent py-4 px-1 text-sm font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300">
                        Historique
                    </button>
                </nav>
            </div>
        </div>

        <!-- Expertises Tab - Specialist View -->
        <div id="content-expertises" class="tab-content">
            <div class="space-y-4">
                <c:choose>
                    <c:when test="${not empty requests}">
                        <c:forEach var="request" items="${requests}">
                            <!-- Request Card -->
                            <div class="bg-white rounded-lg shadow overflow-hidden border-l-4 ${request.requestStatus.name() == 'URGENT' ? 'border-red-500' :
                    request.requestStatus.name() == 'NORMAL' ? 'border-blue-500' : 'border-gray-500'}">
                                <div class="p-6">
                                    <div class="flex justify-between items-start mb-4">
                                        <div class="flex-1">
                                            <!-- Patient Name and Status -->
                                            <div class="flex items-center gap-3 mb-2">
                                                <h3 class="text-lg font-semibold text-gray-900">
                                                        ${request.consultation.medicaleFile.patient.firstName} ${request.consultation.medicaleFile.patient.lastName}
                                                </h3>
                                                <!-- Request Status Badge -->
                                                <span class="px-2 py-1 text-xs font-semibold rounded-full ${request.requestStatus.name() == 'PENDING' ? 'bg-yellow-100 text-yellow-800' :
                                        request.requestStatus.name() == 'ACCEPTED' ? 'bg-green-100 text-green-800' :
                                        request.requestStatus.name() == 'REJECTED' ? 'bg-red-100 text-red-800' : 'bg-gray-100 text-gray-800'}">
                                            <c:choose>
                                                <c:when test="${request.requestStatus.name() == 'PENDING'}">EN ATTENTE</c:when>
                                                <c:when test="${request.requestStatus.name() == 'ACCEPTED'}">ACCEPTÉE</c:when>
                                                <c:when test="${request.requestStatus.name() == 'REJECTED'}">REJETÉE</c:when>
                                                <c:otherwise>${request.requestStatus}</c:otherwise>
                                            </c:choose>
                                        </span>
                                                <!-- Priority Badge -->
                                                <span class="px-2 py-1 text-xs font-semibold rounded-full ${request.description.contains('URGENTE') || request.description.contains('URGENT') ? 'bg-red-100 text-red-800' : 'bg-blue-100 text-blue-800'}">
                                            URGENTE
                                        </span>
                                            </div>

                                            <!-- Patient Age and Request Date -->
                                            <c:set var="now" value="<%= java.time.LocalDate.now() %>"/>
                                            <c:set var="birthDate"
                                                   value="${request.consultation.medicaleFile.patient.dateOfBirth}"/>
                                            <c:set var="age"
                                                   value="${now.year - birthDate.year - ((now.monthValue > birthDate.monthValue || (now.monthValue == birthDate.monthValue && now.dayOfMonth >= birthDate.dayOfMonth)) ? 0 : 1)}"/>
                                            <p class="text-sm text-gray-600 mb-3">
                                                    ${age} ans • Demande reçue le <fmt:formatDate
                                                    value="${request.createdAt}" pattern="dd/MM/yyyy"/> à
                                                <fmt:formatDate value="${request.createdAt}" pattern="HH:mm"/>
                                            </p>

                                            <!-- Generalist and Appointment Slot -->
                                            <div class="grid grid-cols-2 gap-4 mb-4">
                                                <div>
                                                    <p class="text-xs font-medium text-gray-500 mb-1">Médecin
                                                        Généraliste</p>
                                                    <p class="text-sm text-gray-900">
                                                        Dr. ${request.consultation.generalist.lastName} ${request.consultation.generalist.firstName}
                                                    </p>
                                                </div>
                                                <div>
                                                    <p class="text-xs font-medium text-gray-500 mb-1">Créneau</p>
                                                    <p class="text-sm text-gray-900">
                                                        <fmt:formatDate value="${request.formattedConsultationDate}" pattern="dd/MM/yyyy"/>
                                                    </p>
                                                </div>
                                            </div>

                                            <!-- Question/Description -->
                                            <div class="bg-gray-50 p-4 rounded-lg mb-4">
                                                <p class="text-sm font-medium text-gray-700 mb-2">Question posée:</p>
                                                <p class="text-sm text-gray-600">${request.description}</p>
                                            </div>

                                            <!-- Patient Medical Information -->
                                            <div class="bg-blue-50 p-4 rounded-lg">
                                                <p class="text-sm font-medium text-gray-700 mb-2">Information patient:</p>
                                                <div class="grid grid-cols-2 gap-3 text-sm text-gray-600">
                                                    <div>
                                                        <strong>Signes vitaux:</strong>
                                                        TA: ${request.consultation.medicaleFile.bloodPresure} mmHg,
                                                        Temp: ${request.consultation.medicaleFile.temperature}°C
                                                    </div>
                                                    <div>
                                                        <strong>Pouls:</strong> ${request.consultation.medicaleFile.pulse}
                                                        bpm
                                                    </div>
                                                    <div>
                                                        <strong>SpO₂:</strong> ${request.consultation.medicaleFile.oxygenSaturation}%
                                                    </div>
                                                    <div>
                                                        <strong>Douleur:</strong> ${request.consultation.medicaleFile.pain}/10
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Action Footer -->
                                    <div class="flex justify-between items-center pt-4 border-t border-gray-200">
                                        <p class="text-lg font-bold text-blue-600">${request.cost} DH</p>
                                        <div class="flex gap-2">
                                            <!-- Respond/Accept (if PENDING) -->
                                            <c:if test="${request.requestStatus.name() == 'PENDING'}">
                                                <a href="${pageContext.request.contextPath}/request/respond?id=${request.id}"
                                                        class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-lg font-medium transition">
                                                    Répondre
                                                </a>
                                            </c:if>

                                            <!-- Already Accepted -->
                                            <c:if test="${request.requestStatus.name() == 'IN_PROGRESS'}">
                                                <button disabled
                                                        class="bg-green-600 text-white px-6 py-2 rounded-lg font-medium opacity-75 cursor-not-allowed">
                                                    In progress
                                                </button>
                                            </c:if>

                                            <!-- Rejected -->
                                            <c:if test="${request.requestStatus.name() == 'COMPLETED'}">
                                                <button disabled
                                                        class="bg-red-600 text-white px-6 py-2 rounded-lg font-medium opacity-75 cursor-not-allowed">
                                                    Completé
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- Empty State -->
                        <div class="bg-white rounded-lg shadow p-12 text-center">
                            <svg class="mx-auto h-12 w-12 text-gray-400 mb-4" fill="none" stroke="currentColor"
                                 viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"></path>
                            </svg>
                            <h3 class="mt-2 text-sm font-medium text-gray-900">Aucune demande d'expertise</h3>
                            <p class="mt-1 text-sm text-gray-500">Vous n'avez aucune demande d'expertise en attente pour
                                le moment.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Schedule Tab -->
        <div id="content-schedule" class="space-y-4 tab-content hidden">
            <form action="${pageContext.request.contextPath}/dashboard/specialists/agenda"
                  method="post" class="space-y-2 border-b border-gray-200 pb-4">
                <!-- pick any date inside the week you want to publish (we'll compute week start) -->
                <div>
                    <label class="block">Reference date (any date inside desired week)</label>
                    <input type="date" name="referenceDate" required class="mt-1 p-2 border rounded w-full">
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block">Daily start time</label>
                        <input type="time" name="startTime" required class="mt-1 p-2 border rounded w-full">
                    </div>
                    <div>
                        <label class="block">Daily end time</label>
                        <input type="time" name="endTime" required class="mt-1 p-2 border rounded w-full">
                    </div>
                </div>

                <div>
                    <label class="block">Slot duration (minutes)</label>
                    <input type="number" name="slotDuration" min="5" value="30" required
                           class="mt-1 p-2 border rounded w-24">
                </div>

                <div>
                    <label class="block mb-1">Apply to days</label>
                    <div class="flex gap-2">
                        <label><input type="checkbox" name="days" value="MONDAY" checked> Mon</label>
                        <label><input type="checkbox" name="days" value="TUESDAY" checked> Tue</label>
                        <label><input type="checkbox" name="days" value="WEDNESDAY" checked> Wed</label>
                        <label><input type="checkbox" name="days" value="THURSDAY" checked> Thu</label>
                        <label><input type="checkbox" name="days" value="FRIDAY" checked> Fri</label>
                        <label><input type="checkbox" name="days" value="SATURDAY"> Sat</label>
                        <label><input type="checkbox" name="days" value="SUNDAY"> Sun</label>
                    </div>
                </div>

                <!-- Hidden: specialist id or use session server-side -->
                <input type="hidden" name="specialistId" value="${sessionScope.user.id}"/>

                <div>
                    <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded">Create agenda for this week
                    </button>
                </div>
            </form>

            <div class="mx-auto mt-2 bg-white shadow-md rounded-lg p-6">
                <c:if test="${empty agendas}">
                    <p class="text-gray-500">No agenda slots found for this specialist.</p>
                </c:if>

                <c:if test="${not empty agendas}">
                    <table class="min-w-full border-collapse border border-gray-200">
                        <thead class="bg-gray-100">
                        <tr>
                            <th class="border border-gray-200 px-4 py-2">Date</th>
                            <th class="border border-gray-200 px-4 py-2">Start Time</th>
                            <th class="border border-gray-200 px-4 py-2">End Time</th>
                            <th class="border border-gray-200 px-4 py-2">Status</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="a" items="${agendas}">
                            <tr class="hover:bg-gray-50">
                                <td class="border border-gray-200 px-4 py-2">${a.date}</td>
                                <td class="border border-gray-200 px-4 py-2">${a.startTime}</td>
                                <td class="border border-gray-200 px-4 py-2">${a.endTime}</td>
                                <td class="border border-gray-200 px-4 py-2">
                                    <c:choose>
                                        <c:when test="${a.available}">
                                            <span class="text-green-600 font-semibold">Available</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-red-600 font-semibold">Booked</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>
        </div>

        <!-- History Tab -->
        <div id="content-history" class="tab-content hidden">
            <div class="bg-white rounded-lg shadow overflow-hidden">
                <div class="px-6 py-4 border-b border-gray-200">
                    <h2 class="text-lg font-semibold text-gray-900">Historique des Expertises</h2>
                </div>
                <div class="divide-y divide-gray-200">
                    <!-- History Item 1 -->
                    <div class="p-6 hover:bg-gray-50">
                        <div class="flex justify-between items-start">
                            <div class="flex-1">
                                <div class="flex items-center gap-3 mb-2">
                                    <h3 class="text-lg font-semibold text-gray-900">Hassan Idrissi</h3>
                                    <span class="px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">TERMINÉE</span>
                                </div>
                                <p class="text-sm text-gray-600 mb-3">62 ans • Traité le 10/10/2025</p>

                                <div class="bg-gray-50 p-4 rounded-lg mb-3">
                                    <p class="text-sm font-medium text-gray-700 mb-2">Question:</p>
                                    <p class="text-sm text-gray-600">Grain de beauté suspect, évolution récente, avis
                                        pour biopsie?</p>
                                </div>

                                <div class="bg-green-50 p-4 rounded-lg">
                                    <p class="text-sm font-medium text-gray-700 mb-2">Votre avis:</p>
                                    <p class="text-sm text-gray-600">Lésion suspecte avec critères ABCDE positifs. Je
                                        recommande une biopsie excisionnelle urgente. Orientation vers chirurgie
                                        dermatologique dans les 48h.</p>
                                </div>
                            </div>
                            <div class="text-right">
                                <p class="text-lg font-bold text-gray-900">300 DH</p>
                            </div>
                        </div>
                    </div>

                    <!-- History Item 2 -->
                    <div class="p-6 hover:bg-gray-50">
                        <div class="flex justify-between items-start">
                            <div class="flex-1">
                                <div class="flex items-center gap-3 mb-2">
                                    <h3 class="text-lg font-semibold text-gray-900">Zineb Alaoui</h3>
                                    <span class="px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">TERMINÉE</span>
                                </div>
                                <p class="text-sm text-gray-600 mb-3">35 ans • Traité le 09/10/2025</p>

                                <div class="bg-gray-50 p-4 rounded-lg mb-3">
                                    <p class="text-sm font-medium text-gray-700 mb-2">Question:</p>
                                    <p class="text-sm text-gray-600">Chute de cheveux importante post-partum, traitement
                                        adapté?</p>
                                </div>

                                <div class="bg-green-50 p-4 rounded-lg">
                                    <p class="text-sm font-medium text-gray-700 mb-2">Votre avis:</p>
                                    <p class="text-sm text-gray-600">Effluvium télogène post-partum classique.
                                        Traitement: compléments alimentaires (Biotine, Zinc, Fer si carence). Évolution
                                        spontanée favorable en 6-12 mois. Rassurer la patiente.</p>
                                </div>
                            </div>
                            <div class="text-right">
                                <p class="text-lg font-bold text-gray-900">300 DH</p>
                            </div>
                        </div>
                    </div>

                    <!-- History Item 3 -->
                    <div class="p-6 hover:bg-gray-50">
                        <div class="flex justify-between items-start">
                            <div class="flex-1">
                                <div class="flex items-center gap-3 mb-2">
                                    <h3 class="text-lg font-semibold text-gray-900">Omar Benjelloun</h3>
                                    <span class="px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">TERMINÉE</span>
                                </div>
                                <p class="text-sm text-gray-600 mb-3">19 ans • Traité le 08/10/2025</p>

                                <div class="bg-gray-50 p-4 rounded-lg mb-3">
                                    <p class="text-sm font-medium text-gray-700 mb-2">Question:</p>
                                    <p class="text-sm text-gray-600">Acné sévère nodulaire résistant aux antibiotiques,
                                        indication isotrétinoïne?</p>
                                </div>

                                <div class="bg-green-50 p-4 rounded-lg">
                                    <p class="text-sm font-medium text-gray-700 mb-2">Votre avis:</p>
                                    <p class="text-sm text-gray-600">Indication formelle d'isotrétinoïne. Bilan
                                        pré-thérapeutique complet nécessaire. Prescription initiale 0.5mg/kg/j.
                                        Surveillance mensuelle hépatique et lipidique. Contraception obligatoire si
                                        femme.</p>
                                </div>
                            </div>
                            <div class="text-right">
                                <p class="text-lg font-bold text-gray-900">300 DH</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Profile Configuration Modal -->
    <div id="profileModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
        <div class="relative top-20 mx-auto p-5 border w-full max-w-2xl shadow-lg rounded-md bg-white">
            <div class="flex justify-between items-center mb-4">
                <h3 class="text-xl font-semibold text-gray-900">Configuration du Profil</h3>
                <button onclick="closeProfileModal()" class="text-gray-400 hover:text-gray-600">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>

            <form class="space-y-6">
                <div class="bg-blue-50 p-4 rounded-lg">
                    <div class="flex items-center gap-3">
                        <div class="bg-blue-100 rounded-full p-3">
                            <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                            </svg>
                        </div>
                        <div>
                            <h4 class="font-semibold text-gray-900">Dr. Laila Bennani</h4>
                            <p class="text-sm text-gray-600">Médecin Spécialiste</p>
                        </div>
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Spécialité médicale *</label>
                    <select class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        <option value="">-- Sélectionner --</option>
                        <option value="cardiologie">Cardiologie</option>
                        <option value="dermatologie" selected>Dermatologie</option>
                        <option value="pneumologie">Pneumologie</option>
                        <option value="neurologie">Neurologie</option>
                        <option value="endocrinologie">Endocrinologie</option>
                        <option value="gastro">Gastro-entérologie</option>
                        <option value="rhumatologie">Rhumatologie</option>
                        <option value="pediatrie">Pédiatrie</option>
                        <option value="ophtalmologie">Ophtalmologie</option>
                    </select>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Tarif de consultation (DH) *</label>
                    <div class="relative">
                        <input type="number" value="300" min="100" step="50"
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        <span class="absolute right-4 top-2 text-gray-500">DH</span>
                    </div>
                    <p class="text-xs text-gray-500 mt-1">Tarif par consultation de 30 minutes</p>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Durée moyenne de consultation</label>
                    <div class="relative">
                        <input type="number" value="30" readonly
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg bg-gray-100 cursor-not-allowed">
                        <span class="absolute right-4 top-2 text-gray-500">minutes</span>
                    </div>
                    <p class="text-xs text-gray-500 mt-1">Durée fixe à 30 minutes</p>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Années d'expérience</label>
                    <input type="number" value="15" min="0"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Bio professionnelle</label>
                    <textarea rows="4" placeholder="Décrivez votre parcours, vos domaines d'expertise..."
                              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">Dermatologue spécialisée en dermatologie médicale et esthétique. Expérience de 15 ans dans le traitement des pathologies cutanées complexes.</textarea>
                </div>

                <div class="flex justify-end gap-3 pt-4 border-t border-gray-200">
                    <button type="button" onclick="closeProfileModal()"
                            class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 font-medium transition">
                        Annuler
                    </button>
                    <button type="submit"
                            class="px-6 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg font-medium transition">
                        Enregistrer les modifications
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Respond to Expertise Modal -->
    <div id="respondModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
        <div class="relative top-20 mx-auto p-5 border w-full max-w-4xl shadow-lg rounded-md bg-white mb-20">
            <div class="flex justify-between items-center mb-4">
                <h3 class="text-xl font-semibold text-gray-900">Répondre à la Demande d'Expertise</h3>
                <button onclick="closeRespondModal()" class="text-gray-400 hover:text-gray-600">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>

            <form class="space-y-6">
                <!-- Patient Info Summary -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h4 class="font-semibold text-gray-900 mb-3">Informations du patient</h4>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <p class="text-sm text-gray-600">Patient:</p>
                            <p class="text-sm font-medium text-gray-900">Samira Benjelloun, 27 ans</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-600">Médecin demandeur:</p>
                            <p class="text-sm font-medium text-gray-900">Dr. Hassan Tazi</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-600">Priorité:</p>
                            <p class="text-sm font-medium text-red-600">URGENTE</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-600">Créneau:</p>
                            <p class="text-sm font-medium text-gray-900">11/10/2025 - 14:00</p>
                        </div>
                    </div>
                </div>

                <!-- Question Asked -->
                <div class="bg-gray-50 p-4 rounded-lg">
                    <h4 class="font-semibold text-gray-900 mb-2">Question posée:</h4>
                    <p class="text-sm text-gray-600">Patiente présente une éruption cutanée avec desquamation depuis 3
                        semaines. Pas de réponse aux corticoïdes topiques. Diagnostic différentiel entre eczéma et
                        psoriasis? Photos jointes dans le dossier.</p>
                </div>

                <!-- Medical Opinion -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Avis médical *</label>
                    <textarea rows="6" placeholder="Votre diagnostic, analyse et conclusions..."
                              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                              required></textarea>
                    <p class="text-xs text-gray-500 mt-1">Fournissez votre avis et votre analyse détaillée sur cette consultation</p>
                </div>

                <!-- Cost Confirmation -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <div class="flex justify-between items-center">
                        <span class="text-sm font-medium text-gray-700">Honoraires de consultation:</span>
                        <span class="text-2xl font-bold text-blue-600">300 DH</span>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex justify-end gap-3 pt-4 border-t border-gray-200">
                    <button type="button" onclick="closeRespondModal()"
                            class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 font-medium transition">
                        Annuler
                    </button>
                    <button type="submit"
                            class="px-6 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium transition flex items-center gap-2">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M5 13l4 4L19 7"></path>
                        </svg>
                        Envoyer l'Avis et Marquer comme Terminée
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Tab Management
        function switchTab(tabName) {
            document.querySelectorAll('.tab-content').forEach(el => el.classList.add('hidden'));
            document.querySelectorAll('button[id^="tab-"]').forEach(el => {
                el.classList.remove('tab-active', 'border-blue-500', 'text-blue-600');
                el.classList.add('tab-inactive', 'text-gray-500');
            });
            document.getElementById('content-' + tabName).classList.remove('hidden');
            document.getElementById('tab-' + tabName).classList.add('tab-active', 'border-blue-500', 'text-blue-600');
        }

        // Modal Management
        function showProfileModal() {
            document.getElementById('profileModal').classList.remove('hidden');
        }

        function closeProfileModal() {
            document.getElementById('profileModal').classList.add('hidden');
        }

        function respondExpertise(id) {
            document.getElementById('respondModal').classList.remove('hidden');
        }

        function closeRespondModal() {
            document.getElementById('respondModal').classList.add('hidden');
        }

        function logout() {
            if (confirm('Êtes-vous sûr de vouloir vous déconnecter?')) {
                window.location.href = 'login.jsp';
            }
        }

        function filterExpertises() {
            alert('Filtrage des expertises appliqué');
        }

        // Close modals when clicking outside
        document.getElementById('profileModal').addEventListener('click', function (e) {
            if (e.target === this) {
                closeProfileModal();
            }
        });

        document.getElementById('respondModal').addEventListener('click', function (e) {
            if (e.target === this) {
                closeRespondModal();
            }
        });

        // Form submission handlers
        document.addEventListener('DOMContentLoaded', function () {
            // Profile form
            const profileForm = document.querySelector('#profileModal form');
            if (profileForm) {
                profileForm.addEventListener('submit', function (e) {
                    e.preventDefault();
                    alert('Profil mis à jour avec succès!');
                    closeProfileModal();
                });
            }

            // Response form
            const respondForm = document.querySelector('#respondModal form');
            if (respondForm) {
                respondForm.addEventListener('submit', function (e) {
                    e.preventDefault();
                    alert('Avis envoyé avec succès! La demande a été marquée comme terminée.');
                    closeRespondModal();
                    // Refresh the page or update the UI
                    location.reload();
                });
            }
        });
    </script>
</div>
</body>
</html>