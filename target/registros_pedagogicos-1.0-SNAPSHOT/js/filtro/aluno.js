$("#table-aluno").DataTable({
                                                    initComplete: function () {
                                                        this.api().columns().every(function () {
                                                            var column = this;
                                                            var select = $('<select class="custom-select w-auto"><option value=""></option></select>')
                                                                    .appendTo($(column.header()))
                                                                    .on('change', function () {
                                                                        var val = $.fn.dataTable.util.escapeRegex(
                                                                                $(this).val()
                                                                                );
                                                                        column
                                                                                .search(val ? '^' + val + '$' : '', true, false)
                                                                                .draw();
                                                                    });
                                                            column.data().unique().sort().each(function (d, j) {
                                                                select.append('<option value="' + d + '">' + d + '</option>')
                                                            });
                                                        });
                                                    },
                                                    "language": {
                                                        "url": "/registros_pedagogicos/js/addons/datatables-pt-br.json"
                                                    },
                                                    "order": [[0, "asc"]],
                                                    "pagingType": "full_numbers"
                                                });
                                                $(".datatables_length").addClass("bs-select");