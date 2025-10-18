<div class="container mx-auto px-4 py-8">
    <!-- Header -->
    <header class="mb-8">
        <div class="flex items-center justify-between">
            <div>
                <h1 class="text-3xl font-bold text-blue-800 mb-2">
                    <i class="fas fa-hospital-alt mr-3"></i>Système de Gestion Médicale
                </h1>
                <nav class="text-sm text-gray-600">
                    <a href="${pageContext.request.contextPath}/" class="text-blue-600 hover:text-blue-800">
                        <i class="fas fa-home mr-1"></i>Accueil
                    </a>
                    <span class="mx-2">›</span>
                    <span>Nouveau dossier médical</span>
                </nav>
            </div>
            <div class="bg-blue-100 text-blue-800 px-4 py-2 rounded-lg">
                <i class="fas fa-user-injured mr-2"></i>
                <span class="font-medium">${patient.firstName} ${patient.lastName}</span>
            </div>
        </div>
    </header>

    <div class="max-w-4xl mx-auto">
        <!-- Patient Info Card -->
        <div class="bg-white rounded-xl shadow-md p-6 mb-8 border-l-4 border-blue-500">
            <div class="flex items-center justify-between">
                <div>
                    <h2 class="text-xl font-semibold text-blue-700 mb-2 flex items-center">
                        <i class="fas fa-file-medical mr-2"></i>Nouveau dossier médical
                    </h2>
                    <p class="text-gray-600">Remplissez les signes vitaux pour ${patient.firstName} ${patient.lastName}</p>
                </div>
                <div class="text-right">
                    <p class="text-sm text-gray-500">ID Patient</p>
                    <p class="font-mono font-medium">${patient.id}</p>
                </div>
            </div>
        </div>

        <!-- Medical Form -->
        <div class="bg-white rounded-xl shadow-md p-6">
            <form action="${pageContext.request.contextPath}/addMedicaleFile" method="post">
                <input type="hidden" name="patientId" value="${patient.id}">

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Temperature -->
                    <div class="space-y-2">
                        <label class="block text-gray-700 font-medium">
                            <i class="fas fa-thermometer-half mr-2 text-red-500"></i>Température (°C)
                        </label>
                        <div class="relative">
                            <input type="number" step="0.1" name="temperature" required
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg vital-sign-input focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                   placeholder="Ex: 36.8">
                            <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                                <span class="text-gray-400">°C</span>
                            </div>
                        </div>
                        <p class="text-xs text-gray-500">Normale: 36.1°C - 37.2°C</p>
                    </div>

                    <!-- Pulse -->
                    <div class="space-y-2">
                        <label class="block text-gray-700 font-medium">
                            <i class="fas fa-heartbeat mr-2 text-red-500"></i>Pouls (bpm)
                        </label>
                        <div class="relative">
                            <input type="number" name="pulse" required
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg vital-sign-input focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                   placeholder="Ex: 72">
                            <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                                <span class="text-gray-400">bpm</span>
                            </div>
                        </div>
                        <p class="text-xs text-gray-500">Normale: 60 - 100 bpm</p>
                    </div>

                    <!-- Blood Pressure -->
                    <div class="space-y-2">
                        <label class="block text-gray-700 font-medium">
                            <i class="fas fa-tachometer-alt mr-2 text-red-500"></i>Pression artérielle (mmHg)
                        </label>
                        <input type="number" name="bloodPresure" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg vital-sign-input focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                               placeholder="Ex: 120">
                        <p class="text-xs text-gray-500">Normale: 120/80 mmHg</p>
                    </div>

                    <!-- Respiratory Rate -->
                    <div class="space-y-2">
                        <label class="block text-gray-700 font-medium">
                            <i class="fas fa-wind mr-2 text-red-500"></i>Fréquence respiratoire
                        </label>
                        <div class="relative">
                            <input type="number" name="respiratoryRate" required
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg vital-sign-input focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                   placeholder="Ex: 16">
                            <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                                <span class="text-gray-400">resp/min</span>
                            </div>
                        </div>
                        <p class="text-xs text-gray-500">Normale: 12 - 20 resp/min</p>
                    </div>

                    <!-- Oxygen Saturation -->
                    <div class="space-y-2">
                        <label class="block text-gray-700 font-medium">
                            <i class="fas fa-lungs mr-2 text-red-500"></i>Saturation O₂ (%)
                        </label>
                        <div class="relative">
                            <input type="number" step="0.1" name="oxygenSaturation" required
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg vital-sign-input focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                   placeholder="Ex: 98.5">
                            <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                                <span class="text-gray-400">%</span>
                            </div>
                        </div>
                        <p class="text-xs text-gray-500">Normale: 95% - 100%</p>
                    </div>

                    <!-- Pain Level -->
                    <div class="space-y-2">
                        <label class="block text-gray-700 font-medium">
                            <i class="fas fa-stethoscope mr-2 text-red-500"></i>Douleur (0–10)
                        </label>
                        <div class="relative">
                            <input type="number" name="pain" min="0" max="10" required
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg vital-sign-input focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                   placeholder="Ex: 3">
                            <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                                <span class="text-gray-400">/10</span>
                            </div>
                        </div>
                        <div class="flex justify-between text-xs text-gray-500">
                            <span>0 = Aucune</span>
                            <span>10 = Extrême</span>
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="mt-8 pt-6 border-t border-gray-200">
                    <div class="flex justify-end space-x-4">
                        <a href="${pageContext.request.contextPath}/"
                           class="px-6 py-3 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition duration-200 flex items-center">
                            <i class="fas fa-arrow-left mr-2"></i>Retour
                        </a>
                        <button type="submit"
                                class="bg-blue-600 hover:bg-blue-700 text-white font-medium px-6 py-3 rounded-lg transition duration-200 flex items-center">
                            <i class="fas fa-save mr-2"></i>Enregistrer le dossier
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Vital Signs Reference -->
        <div class="mt-8 bg-blue-50 rounded-xl p-6 border border-blue-200">
            <h3 class="text-lg font-medium text-blue-800 mb-4 flex items-center">
                <i class="fas fa-info-circle mr-2"></i>Référence des signes vitaux normaux
            </h3>
            <div class="grid grid-cols-2 md:grid-cols-3 gap-4 text-sm">
                <div class="flex items-center">
                    <div class="w-3 h-3 bg-green-500 rounded-full mr-2"></div>
                    <span>Température: 36.1°C - 37.2°C</span>
                </div>
                <div class="flex items-center">
                    <div class="w-3 h-3 bg-green-500 rounded-full mr-2"></div>
                    <span>Pouls: 60 - 100 bpm</span>
                </div>
                <div class="flex items-center">
                    <div class="w-3 h-3 bg-green-500 rounded-full mr-2"></div>
                    <span>Pression art.: 120/80 mmHg</span>
                </div>
                <div class="flex items-center">
                    <div class="w-3 h-3 bg-green-500 rounded-full mr-2"></div>
                    <span>Respiratoire: 12 - 20/min</span>
                </div>
                <div class="flex items-center">
                    <div class="w-3 h-3 bg-green-500 rounded-full mr-2"></div>
                    <span>O₂ Saturation: 95% - 100%</span>
                </div>
                <div class="flex items-center">
                    <div class="w-3 h-3 bg-green-500 rounded-full mr-2"></div>
                    <span>Douleur: 0 (Aucune)</span>
                </div>
            </div>
        </div>
    </div>
</div>