<%@ include file="../layout/header.jsp" %>

<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <!-- Tabs -->
    <div class="mb-6">
        <div class="border-b border-gray-200">
            <nav class="-mb-px flex space-x-8">
                <button onclick="switchTab('queue')" id="tab-queue"
                        class="tab-active border-b-2 border-blue-500 py-4 px-1 text-sm font-medium text-blue-600">
                    File d'attente
                </button>
                <button onclick="switchTab('consultations')" id="tab-consultations"
                        class="tab-inactive border-b-2 border-transparent py-4 px-1 text-sm font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300">
                    Mes Consultations
                </button>
                <button onclick="switchTab('expertises')" id="tab-expertises"
                        class="tab-inactive border-b-2 border-transparent py-4 px-1 text-sm font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300">
                    Demandes d'Expertise
                </button>
            </nav>
        </div>
    </div>

    <!-- Queue Tab -->
    <div id="content-queue" class="tab-content">
        <div class="bg-white rounded-lg shadow overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-200">
                <h2 class="text-lg font-semibold text-gray-900">Patients en Attente</h2>
            </div>
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Patient</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Heure d'arrivée</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Action</th>
                    </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                    <c:forEach var="ticket" items="${tickets}">
                        <tr class="hover:bg-gray-50">
                            <td class="px-6 py-4">
                                <div class="text-sm font-medium text-gray-900">${ticket.patient.lastName} ${ticket.patient.firstName}</div>
                            </td>
                            <td class="px-6 py-4 text-sm text-gray-900">${ticket.formattedTime}</td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <c:choose>
                                    <c:when test="${ticket.status == 'ACTIVE'}">
                                        <span class="text-yellow-500">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-green-500">Completed</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4">
                                <c:choose>
                                    <c:when test="${ticket.status == 'ACTIVE'}">
                                        <a href="${pageContext.request.contextPath}/dashboard/consultations?patientId=${ticket.patient.id}"
                                                class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition start-btn"
                                                class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition">
                                            Consulter
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-gray-600 bg-gray-100 px-6 py-2">Consultation terminée</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Consultations Tab -->
    <div id="content-consultations" class="tab-content hidden">
        <div class="bg-white rounded-lg shadow overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-200">
                <h2 class="text-lg font-semibold text-gray-900">Mes Consultations</h2>
            </div>
            <div class="divide-y divide-gray-200">
                <!-- Consultation Card 1 -->
                <div class="p-6 hover:bg-gray-50">
                    <div class="flex justify-between items-start">
                        <div class="flex-1">
                            <div class="flex items-center gap-3 mb-2">
                                <h3 class="text-lg font-semibold text-gray-900">Mohammed Kadiri</h3>
                                <span class="px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">Terminée</span>
                            </div>
                            <p class="text-sm text-gray-600 mb-2">58 ans • Consultation du 11/10/2025 à 10:30</p>
                            <div class="text-sm text-gray-700 space-y-1">
                                <p><strong>Motif:</strong> Douleurs thoraciques</p>
                                <p><strong>Diagnostic:</strong> Hypertension artérielle</p>
                                <p><strong>Traitement:</strong> Amlodipine 5mg, 1 fois/jour</p>
                            </div>
                        </div>
                        <div class="text-right">
                            <p class="text-lg font-bold text-gray-900">150 DH</p>
                            <button onclick="viewConsultation(1)"
                                    class="mt-2 text-blue-600 hover:text-blue-700 text-sm font-medium">
                                Voir détails
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Expertises Tab -->
    <div id="content-expertises" class="tab-content hidden">
        <div class="bg-white rounded-lg shadow overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-200">
                <h2 class="text-lg font-semibold text-gray-900">Demandes d'Expertise</h2>
            </div>
            <div class="divide-y divide-gray-200">
                <!-- Expertise Card 1 -->
                <div class="p-6 hover:bg-gray-50">
                    <div class="flex justify-between items-start">
                        <div class="flex-1">
                            <div class="flex items-center gap-3 mb-3">
                                <h3 class="text-lg font-semibold text-gray-900">Samira Benjelloun - Dermatologie</h3>
                                <span class="px-2 py-1 text-xs font-semibold rounded-full bg-yellow-100 text-yellow-800">En attente</span>
                                <span class="px-2 py-1 text-xs font-semibold rounded-full bg-red-100 text-red-800">URGENTE</span>
                            </div>
                            <p class="text-sm text-gray-600 mb-3">Demandée le 11/10/2025 à 09:15</p>
                            <div class="bg-gray-50 p-4 rounded-lg mb-3">
                                <p class="text-sm font-medium text-gray-700 mb-2">Question posée:</p>
                                <p class="text-sm text-gray-600">Patient présente une éruption cutanée avec desquamation
                                    depuis 3 semaines. Pas de réponse aux corticoïdes topiques. Diagnostic différentiel
                                    entre eczéma et psoriasis?</p>
                            </div>
                            <div class="flex items-center gap-4 text-sm text-gray-600">
                                <div class="flex items-center gap-1">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                              d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                    </svg>
                                    <span>Dr. Laila Bennani</span>
                                </div>
                                <div class="flex items-center gap-1">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                              d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                    </svg>
                                    <span>Créneau: 11/10/2025 - 14:00</span>
                                </div>
                                <div class="flex items-center gap-1">
                                    <span class="font-medium">Tarif: 300 DH</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Expertise Card 2 -->
                <div class="p-6 hover:bg-gray-50">
                    <div class="flex justify-between items-start">
                        <div class="flex-1">
                            <div class="flex items-center gap-3 mb-3">
                                <h3 class="text-lg font-semibold text-gray-900">Hassan Idrissi - Cardiologie</h3>
                                <span class="px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">Répondu</span>
                                <span class="px-2 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-800">NORMALE</span>
                            </div>
                            <p class="text-sm text-gray-600 mb-3">Demandée le 10/10/2025 - Répondu le 11/10/2025</p>
                            <div class="bg-gray-50 p-4 rounded-lg mb-3">
                                <p class="text-sm font-medium text-gray-700 mb-2">Avis du spécialiste:</p>
                                <p class="text-sm text-gray-600">ECG montre des signes d'hypertrophie ventriculaire
                                    gauche. Je recommande un échocardiogramme et un suivi cardiologique dans les 2
                                    semaines. Poursuivre le traitement antihypertenseur.</p>
                            </div>
                            <div class="flex items-center gap-4 text-sm text-gray-600">
                                <div class="flex items-center gap-1">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                              d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                    </svg>
                                    <span>Dr. Rachid Alaoui</span>
                                </div>
                                <div class="flex items-center gap-1">
                                    <span class="font-medium">Tarif: 400 DH</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- New Consultation Modal -->
<div id="consultationModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
    <div class="relative top-20 mx-auto p-5 border w-full max-w-4xl shadow-lg rounded-md bg-white mb-20">
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-xl font-semibold text-gray-900">Nouvelle Consultation</h3>
            <button onclick="closeConsultationModal()" class="text-gray-400 hover:text-gray-600">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </button>
        </div>

        <form class="space-y-6">
            <!-- Patient Info Display -->
            <div class="bg-blue-50 p-4 rounded-lg">
                <h4 class="font-medium text-gray-900 mb-3">Informations du patient</h4>
                <div class="grid grid-cols-2 gap-4 text-sm">
                    <div class="grid grid-cols-2 gap-4 text-sm">
                        <div>
                            <p class="text-gray-600">Signes vitaux:</p>
                            <div id="vitalsContent" class="text-gray-900">
                                <p class="text-gray-500 italic">Aucun dossier médical disponible</p>
                            </div>
                        </div>
                        <div>
                            <p class="text-gray-600">Antécédents:</p>
                            <div id="antecedentsContent" class="text-gray-900">
                                <p class="text-gray-500 italic">Aucun antécédent enregistré</p>
                            </div>
                        </div>
                    </div>

                    <div>
                        <p class="text-gray-600">Antécédents:</p>
                        <p class="text-gray-900">
                            <c:choose>
                                <c:when test="${not empty ticket.patient.medicaleFile.consultations}">
                                    <c:forEach var="consult" items="${ticket.patient.medicaleFile.consultations}"
                                               end="0">
                                        ${consult.diagnostic}
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    Aucun antécédent enregistré
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>

            </div>

            <!-- Consultation Details -->
            <div class="space-y-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Motif de consultation *</label>
                    <input type="text" placeholder="Ex: Douleurs abdominales, Fièvre..."
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Examen clinique</label>
                    <textarea rows="3" placeholder="Observations de l'examen physique..."
                              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"></textarea>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Analyse des symptômes</label>
                    <textarea rows="3" placeholder="Symptômes rapportés par le patient..."
                              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"></textarea>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Observations générales</label>
                    <textarea rows="3" placeholder="Autres observations..."
                              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"></textarea>
                </div>
            </div>

            <!-- Decision Section -->
            <div class="border-t border-gray-200 pt-6">
                <h4 class="font-medium text-gray-900 mb-4">Décision de prise en charge</h4>

                <div class="space-y-4">
                    <!-- Direct Care -->
                    <div class="border border-gray-200 rounded-lg p-4">
                        <h5 class="font-medium text-gray-900 mb-3">Prise en charge directe</h5>
                        <div class="space-y-3">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Diagnostic</label>
                                <input type="text" placeholder="Ex: Grippe saisonnière"
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Traitement prescrit</label>
                                <textarea rows="3" placeholder="Ex: Paracétamol 1g, 3 fois/jour pendant 5 jours"
                                          class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"></textarea>
                            </div>
                        </div>
                    </div>

                    <!-- Or Expert Opinion -->
                    <div class="text-center text-gray-500 font-medium">OU</div>

                    <div class="border border-blue-200 bg-blue-50 rounded-lg p-4">
                        <button type="button" onclick="showExpertiseModal()"
                                class="w-full bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-lg font-medium transition flex items-center justify-center gap-2">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"></path>
                            </svg>
                            Demander un Avis Spécialiste
                        </button>
                    </div>
                </div>
            </div>

            <!-- Cost Display -->
            <div class="bg-gray-50 p-4 rounded-lg">
                <div class="flex justify-between items-center">
                    <span class="text-sm font-medium text-gray-700">Coût de consultation:</span>
                    <span class="text-lg font-bold text-gray-900">150 DH</span>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex justify-end gap-3 pt-4 border-t border-gray-200">
                <button type="button" onclick="closeConsultationModal()"
                        class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 font-medium transition">
                    Annuler
                </button>
                <button type="submit"
                        class="px-6 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium transition">
                    Clôturer la Consultation
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Expertise Request Modal -->
<div id="expertiseModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
    <div class="relative top-20 mx-auto p-5 border w-full max-w-5xl shadow-lg rounded-md bg-white mb-20">
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-xl font-semibold text-gray-900">Demande d'Avis Spécialiste</h3>
            <button onclick="closeExpertiseModal()" class="text-gray-400 hover:text-gray-600">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </button>
        </div>

        <form class="space-y-6">
            <!-- Specialty Selection -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Spécialité requise *</label>
                <select id="specialtySelect" onchange="loadSpecialists()"
                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    <option value="">-- Sélectionner une spécialité --</option>
                    <option value="cardiologue">Cardiologie</option>
                    <option value="dermatologue">Dermatologie</option>
                    <option value="pneumologue">Pneumologie</option>
                    <option value="neurologue">Neurologie</option>
                    <option value="endocrinologue">Endocrinologie</option>
                    <option value="gastro">Gastro-entérologie</option>
                </select>
            </div>

            <!-- Specialists List -->
            <div id="specialistsList" class="hidden">
                <label class="block text-sm font-medium text-gray-700 mb-3">Spécialistes disponibles</label>
                <div class="space-y-3">
                    <!-- Specialist Card 1 -->
                    <div class="border border-gray-200 rounded-lg p-4 hover:border-blue-500 cursor-pointer transition"
                         onclick="selectSpecialist(1)">
                        <div class="flex justify-between items-start">
                            <div class="flex items-start gap-3">
                                <input type="radio" name="specialist" value="1" class="mt-1">
                                <div>
                                    <h4 class="font-medium text-gray-900">Dr. Laila Bennani</h4>
                                    <p class="text-sm text-gray-600">Dermatologue</p>
                                    <div class="flex items-center gap-2 mt-1">
                                            <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                Disponible
                                            </span>
                                        <span class="text-xs text-gray-500">• 15 ans d'expérience</span>
                                    </div>
                                </div>
                            </div>
                            <div class="text-right">
                                <p class="text-lg font-bold text-gray-900">300 DH</p>
                                <p class="text-xs text-gray-500">par consultation</p>
                            </div>
                        </div>
                    </div>

                    <!-- Specialist Card 2 -->
                    <div class="border border-gray-200 rounded-lg p-4 hover:border-blue-500 cursor-pointer transition"
                         onclick="selectSpecialist(2)">
                        <div class="flex justify-between items-start">
                            <div class="flex items-start gap-3">
                                <input type="radio" name="specialist" value="2" class="mt-1">
                                <div>
                                    <h4 class="font-medium text-gray-900">Dr. Karim Idrissi</h4>
                                    <p class="text-sm text-gray-600">Dermatologue</p>
                                    <div class="flex items-center gap-2 mt-1">
                                            <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                Disponible
                                            </span>
                                        <span class="text-xs text-gray-500">• 10 ans d'expérience</span>
                                    </div>
                                </div>
                            </div>
                            <div class="text-right">
                                <p class="text-lg font-bold text-gray-900">250 DH</p>
                                <p class="text-xs text-gray-500">par consultation</p>
                            </div>
                        </div>
                    </div>

                    <!-- Specialist Card 3 -->
                    <div class="border border-gray-200 rounded-lg p-4 hover:border-blue-500 cursor-pointer transition"
                         onclick="selectSpecialist(3)">
                        <div class="flex justify-between items-start">
                            <div class="flex items-start gap-3">
                                <input type="radio" name="specialist" value="3" class="mt-1">
                                <div>
                                    <h4 class="font-medium text-gray-900">Dr. Amina Tazi</h4>
                                    <p class="text-sm text-gray-600">Dermatologue</p>
                                    <div class="flex items-center gap-2 mt-1">
                                            <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                Disponible
                                            </span>
                                        <span class="text-xs text-gray-500">• 20 ans d'expérience</span>
                                    </div>
                                </div>
                            </div>
                            <div class="text-right">
                                <p class="text-lg font-bold text-gray-900">400 DH</p>
                                <p class="text-xs text-gray-500">par consultation</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Time Slots -->
            <div id="timeSlotsSection" class="hidden">
                <label class="block text-sm font-medium text-gray-700 mb-3">Créneaux disponibles</label>
                <div class="grid grid-cols-3 gap-3">
                    <button type="button" onclick="selectSlot(this)"
                            class="time-slot border-2 border-gray-300 rounded-lg p-3 text-sm hover:border-blue-500 transition">
                        <div class="font-medium text-gray-900">Aujourd'hui</div>
                        <div class="text-gray-600">14:00 - 14:30</div>
                    </button>
                    <button type="button" onclick="selectSlot(this)"
                            class="time-slot border-2 border-gray-300 rounded-lg p-3 text-sm hover:border-blue-500 transition">
                        <div class="font-medium text-gray-900">Aujourd'hui</div>
                        <div class="text-gray-600">15:00 - 15:30</div>
                    </button>
                    <button type="button" onclick="selectSlot(this)"
                            class="time-slot border-2 border-gray-300 rounded-lg p-3 text-sm hover:border-blue-500 transition">
                        <div class="font-medium text-gray-900">Aujourd'hui</div>
                        <div class="text-gray-600">16:00 - 16:30</div>
                    </button>
                    <button type="button" onclick="selectSlot(this)"
                            class="time-slot border-2 border-gray-300 rounded-lg p-3 text-sm hover:border-blue-500 transition">
                        <div class="font-medium text-gray-900">Demain</div>
                        <div class="text-gray-600">09:00 - 09:30</div>
                    </button>
                    <button type="button" onclick="selectSlot(this)"
                            class="time-slot border-2 border-gray-300 rounded-lg p-3 text-sm hover:border-blue-500 transition">
                        <div class="font-medium text-gray-900">Demain</div>
                        <div class="text-gray-600">10:00 - 10:30</div>
                    </button>
                    <button type="button" onclick="selectSlot(this)"
                            class="time-slot border-2 border-gray-300 rounded-lg p-3 text-sm hover:border-blue-500 transition">
                        <div class="font-medium text-gray-900">Demain</div>
                        <div class="text-gray-600">11:00 - 11:30</div>
                    </button>
                </div>
            </div>

            <!-- Question and Details -->
            <div id="questionSection" class="hidden space-y-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Question au spécialiste *</label>
                    <textarea rows="4"
                              placeholder="Décrivez précisément la question que vous souhaitez poser au spécialiste..."
                              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"></textarea>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Données et analyses</label>
                    <textarea rows="3" placeholder="Résultats d'examens, analyses, imagerie..."
                              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"></textarea>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Niveau de priorité *</label>
                    <select class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        <option value="URGENTE">URGENTE - Réponse dans les 2h</option>
                        <option value="NORMALE" selected>NORMALE - Réponse sous 24h</option>
                        <option value="NON_URGENTE">NON URGENTE - Réponse sous 48h</option>
                    </select>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Actes techniques médicaux</label>
                    <div class="grid grid-cols-2 gap-3">
                        <label class="flex items-center gap-2 p-3 border border-gray-200 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" class="rounded">
                            <span class="text-sm">Radiographie (100 DH)</span>
                        </label>
                        <label class="flex items-center gap-2 p-3 border border-gray-200 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" class="rounded">
                            <span class="text-sm">Échographie (150 DH)</span>
                        </label>
                        <label class="flex items-center gap-2 p-3 border border-gray-200 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" class="rounded">
                            <span class="text-sm">IRM (800 DH)</span>
                        </label>
                        <label class="flex items-center gap-2 p-3 border border-gray-200 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" class="rounded">
                            <span class="text-sm">Électrocardiogramme (80 DH)</span>
                        </label>
                        <label class="flex items-center gap-2 p-3 border border-gray-200 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" class="rounded">
                            <span class="text-sm">Analyse de sang (120 DH)</span>
                        </label>
                        <label class="flex items-center gap-2 p-3 border border-gray-200 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" class="rounded">
                            <span class="text-sm">Analyse d'urine (60 DH)</span>
                        </label>
                    </div>
                </div>
            </div>

            <!-- Total Cost -->
            <div id="totalCostSection" class="hidden bg-blue-50 p-4 rounded-lg">
                <h4 class="font-medium text-gray-900 mb-3">Coût total de la consultation</h4>
                <div class="space-y-2 text-sm">
                    <div class="flex justify-between">
                        <span class="text-gray-600">Consultation généraliste:</span>
                        <span class="font-medium">150 DH</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-600">Expertise spécialiste:</span>
                        <span class="font-medium" id="expertiseCost">300 DH</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-600">Actes techniques:</span>
                        <span class="font-medium" id="actesCost">0 DH</span>
                    </div>
                    <div class="border-t border-blue-200 pt-2 mt-2 flex justify-between text-lg">
                        <span class="font-bold text-gray-900">Total:</span>
                        <span class="font-bold text-blue-600" id="totalCost">450 DH</span>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex justify-end gap-3 pt-4 border-t border-gray-200">
                <button type="button" onclick="closeExpertiseModal()"
                        class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 font-medium transition">
                    Annuler
                </button>
                <button type="submit"
                        class="px-6 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg font-medium transition">
                    Envoyer la Demande
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    // Tab Management
    function switchTab(tabName) {
        // Hide all content
        document.querySelectorAll('.tab-content').forEach(el => el.classList.add('hidden'));

        // Remove active class from all tabs
        document.querySelectorAll('[id^="tab-"]').forEach(el => {
            el.classList.remove('tab-active', 'border-blue-500', 'text-blue-600');
            el.classList.add('tab-inactive', 'border-transparent', 'text-gray-500');
        });

        // Show selected content
        document.getElementById('content-' + tabName).classList.remove('hidden');

        // Add active class to selected tab
        const activeTab = document.getElementById('tab-' + tabName);
        activeTab.classList.remove('tab-inactive', 'border-transparent', 'text-gray-500');
        activeTab.classList.add('tab-active', 'border-blue-500', 'text-blue-600');
    }

    // Modal Management
    function showConsultationModal() {
        document.getElementById('consultationModal').classList.remove('hidden');
    }

    function closeConsultationModal() {
        document.getElementById('consultationModal').classList.add('hidden');
    }

    function showExpertiseModal() {
        document.getElementById('expertiseModal').classList.remove('hidden');
    }

    function closeExpertiseModal() {
        document.getElementById('expertiseModal').classList.add('hidden');
    }

    function logout() {
        if (confirm('Êtes-vous sûr de vouloir vous déconnecter?')) {
            window.location.href = 'login.jsp';
        }
    }

    // Expertise Modal Functions
    function loadSpecialists() {
        const specialty = document.getElementById('specialtySelect').value;
        if (specialty) {
            document.getElementById('specialistsList').classList.remove('hidden');
        } else {
            document.getElementById('specialistsList').classList.add('hidden');
            document.getElementById('timeSlotsSection').classList.add('hidden');
            document.getElementById('questionSection').classList.add('hidden');
            document.getElementById('totalCostSection').classList.add('hidden');
        }
    }

    function selectSpecialist(id) {
        document.getElementById('timeSlotsSection').classList.remove('hidden');
        document.getElementById('questionSection').classList.add('hidden');
        document.getElementById('totalCostSection').classList.add('hidden');
    }

    function selectSlot(element) {
        // Remove selected class from all slots
        document.querySelectorAll('.time-slot').forEach(el => {
            el.classList.remove('border-blue-500', 'bg-blue-50');
        });

        // Add selected class to clicked slot
        element.classList.add('border-blue-500', 'bg-blue-50');

        // Show question section and total cost
        document.getElementById('questionSection').classList.remove('hidden');
        document.getElementById('totalCostSection').classList.remove('hidden');
    }

    function startConsultation(btn) {
        const patientId = btn.dataset.patientId;
        const temp = btn.dataset.temp;
        const pulse = btn.dataset.pulse;
        const bp = btn.dataset.bp;
        const resp = btn.dataset.resp;
        const spo2 = btn.dataset.spo2;
        const pain = btn.dataset.pain;

        console.log("temp: ", temp, "pulse: ", pulse, "bp: ", bp, "resp: ", resp, "spo2: ", spo2, "pain: ", pain);

        const vitalsEl = document.getElementById('vitalsContent');
        if (vitalsEl) {
            if (temp || pulse || bp || resp || spo2 || pain) {
                vitalsEl.innerHTML = `
                    <p>TA: ${bp || 'N/A'} mmHg • FC: ${pulse || 'N/A'} bpm • Temp: ${temp || 'N/A'}°C</p>
                    <p>FR: ${resp || 'N/A'} cpm • SpO₂: ${spo2 || 'N/A'}% • Douleur: ${pain || 'N/A'}/10</p>
                `;
            } else {
                vitalsEl.innerHTML = '<p class="text-gray-500 italic">Aucun dossier médical disponible</p>';
            }
        }

        // optional: show previous diagnostics
        const antecedentsEl = document.getElementById('antecedentsContent');
        if (antecedentsEl) {
            antecedentsEl.innerHTML = '<p class="text-gray-500 italic">Chargement des antécédents...</p>';
            // (you could later fetch them dynamically via AJAX if needed)
        }

        // show modal
        document.getElementById('consultationModal').classList.remove('hidden');
    }

    function continueConsultation(id) {
        alert('Continuer la consultation #' + id);
    }

    function viewConsultation(id) {
        alert('Voir les détails de la consultation #' + id);
    }

    // Close modals when clicking outside
    document.getElementById('consultationModal').addEventListener('click', function (e) {
        if (e.target === this) {
            closeConsultationModal();
        }
    });

    document.getElementById('expertiseModal').addEventListener('click', function (e) {
        if (e.target === this) {
            closeExpertiseModal();
        }
    });

    // Calculate total cost when checkboxes change
    document.addEventListener('DOMContentLoaded', function () {
        const checkboxes = document.querySelectorAll('input[type="checkbox"]');
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', calculateTotal);
        });
    });

    function calculateTotal() {
        let actesCost = 0;
        const checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');

        checkboxes.forEach(checkbox => {
            const text = checkbox.parentElement.textContent;
            const match = text.match(/\((\d+) DH\)/);
            if (match) {
                actesCost += parseInt(match[1]);
            }
        });

        document.getElementById('actesCost').textContent = actesCost + ' DH';

        const consultationCost = 150;
        const expertiseCost = 300;
        const total = consultationCost + expertiseCost + actesCost;

        document.getElementById('totalCost').textContent = total + ' DH';
    }
</script>
</body>
</html>