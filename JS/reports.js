document.addEventListener('DOMContentLoaded', () => {

    // --- Chart Initialization ---

    // 1. Pacing Report Chart
    const pacingCtx = document.getElementById('pacingChart')?.getContext('2d');
    if (pacingCtx) {
        new Chart(pacingCtx, {
            type: 'bar',
            data: {
                labels: reportData.pacing.labels,
                datasets: [{
                    label: 'This Year Bookings',
                    data: reportData.pacing.thisYear,
                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }, {
                    label: 'Last Year Bookings',
                    data: reportData.pacing.lastYear,
                    backgroundColor: 'rgba(255, 99, 132, 0.6)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    title: { display: true, text: 'Monthly Reservation Comparison' }
                },
                scales: { y: { beginAtZero: true } }
            }
        });
    }

    // 2. Reservation Type Chart (Replaced Source of Business)
    const typeCtx = document.getElementById('typeChart')?.getContext('2d');
    if (typeCtx) {
        new Chart(typeCtx, {
            type: 'pie',
            data: {
                labels: reportData.type.labels,
                datasets: [{
                    label: 'Reservation Types',
                    data: reportData.type.counts,
                    backgroundColor: [
                        'rgba(255, 159, 64, 0.6)',
                        'rgba(75, 192, 192, 0.6)',
                        'rgba(153, 102, 255, 0.6)',
                        'rgba(255, 99, 132, 0.6)',
                        'rgba(54, 162, 235, 0.6)',
                        'rgba(255, 206, 86, 0.6)'
                    ],
                    borderColor: [
                        'rgba(255, 159, 64, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    title: { display: true, text: 'Distribution by Reservation Type' }
                }
            }
        });
    }

    // 3. Guest Demographics Chart
    const demographicsCtx = document.getElementById('demographicsChart')?.getContext('2d');
    if (demographicsCtx) {
        new Chart(demographicsCtx, {
            type: 'doughnut',
            data: {
                labels: ['New Guests', 'Returning Guests'],
                datasets: [{
                    label: 'Guest Type',
                    data: [reportData.demographics.newGuests, reportData.demographics.returningGuests],
                     backgroundColor: [
                        'rgba(255, 206, 86, 0.6)',
                        'rgba(54, 162, 235, 0.6)'
                    ],
                    borderColor: [
                        'rgba(255, 206, 86, 1)',
                        'rgba(54, 162, 235, 1)'
                    ],
                    borderWidth: 1
                }]
            },
             options: {
                responsive: true,
                plugins: {
                    title: { display: true, text: 'New vs. Returning Guests' }
                }
            }
        });
    }

    // --- Export and Print Functionality (Professional Format) ---

    // Export to CSV Function
    document.querySelectorAll('.export-csv').forEach(button => {
        button.addEventListener('click', () => {
            const chartId = button.dataset.target;
            const chartTitle = button.dataset.title || 'Report';
            const chart = Chart.getChart(chartId);
            if (chart) {
                exportChartDataToCSV(chart, chartId + '_data.csv', chartTitle);
            }
        });
    });

    function exportChartDataToCSV(chart, filename, title) {
        const { labels, datasets } = chart.data;
        let csvContent = "data:text/csv;charset=utf-8,";

        // Add Professional Header Title & Dates
        csvContent += `"${title}"\r\n`;
        csvContent += `"Date Range: ${reportData.startDate} to ${reportData.endDate}"\r\n\r\n`;

        // Column Headers
        const header = ['Category', ...datasets.map(d => `"${d.label}"`)].join(',');
        csvContent += header + "\r\n";

        // Rows Data
        labels.forEach((label, index) => {
            const row = [`"${label}"`, ...datasets.map(d => d.data[index])].join(',');
            csvContent += row + "\r\n";
        });
        
        const encodedUri = encodeURI(csvContent);
        const link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", filename);
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }

    // Print professional document Function
    document.querySelectorAll('.print-chart').forEach(button => {
        button.addEventListener('click', () => {
            const chartId = button.dataset.target;
            const chartTitle = button.dataset.title || 'Report Chart';
            const canvas = document.getElementById(chartId);
            
            if (canvas) {
                // Get image of the chart
                const dataUrl = canvas.toDataURL('image/png');
                const currentDate = new Date().toLocaleString();
                
                // Construct Professional HTML Document for printing
                const windowContent = `
                    <!DOCTYPE html>
                    <html>
                    <head>
                        <title>Print - ${chartTitle}</title>
                        <style>
                            body {
                                font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
                                color: #1e293b;
                                padding: 40px;
                                margin: 0 auto;
                                max-width: 900px;
                                text-align: center;
                            }
                            .report-header {
                                border-bottom: 2px solid #e2e8f0;
                                padding-bottom: 20px;
                                margin-bottom: 30px;
                            }
                            .report-header h1 {
                                margin: 0;
                                font-size: 26px;
                                color: #0f172a;
                            }
                            .report-header p {
                                margin: 8px 0 0 0;
                                font-size: 15px;
                                color: #64748b;
                            }
                            .chart-container {
                                background: #fff;
                                border: 1px solid #cbd5e1;
                                border-radius: 8px;
                                padding: 25px;
                                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                                margin-bottom: 30px;
                            }
                            .chart-img {
                                max-width: 100%;
                                height: auto;
                            }
                            .report-footer {
                                font-size: 12px;
                                color: #94a3b8;
                                text-align: center;
                                border-top: 1px solid #e2e8f0;
                                padding-top: 15px;
                            }
                            @media print {
                                body { padding: 0; max-width: 100%; }
                                .chart-container { border: none; box-shadow: none; padding: 0; }
                                @page { margin: 1cm; }
                            }
                        </style>
                    </head>
                    <body>
                        <div class="report-header">
                            <h1>Tavern Publico</h1>
                            <p><strong>${chartTitle}</strong></p>
                            <p>Report Period: ${reportData.startDate} &mdash; ${reportData.endDate}</p>
                        </div>
                        
                        <div class="chart-container">
                            <img src="${dataUrl}" class="chart-img" alt="${chartTitle}">
                        </div>
                        
                        <div class="report-footer">
                            Printed by Admin System on ${currentDate}
                        </div>
                    </body>
                    </html>
                `;

                // Open window and execute print
                const printWin = window.open('', '_blank', 'width=900,height=700');
                printWin.document.open();
                printWin.document.write(windowContent);
                printWin.document.close();
                
                // Wait for the image to load inside the print window before calling print()
                printWin.onload = function() {
                    printWin.focus();
                    setTimeout(() => {
                        printWin.print();
                        printWin.close();
                    }, 250); // slight delay to ensure rendering
                };
            }
        });
    });

});