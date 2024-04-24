#!/usr/bin/env bash

set -eu

pdf_merge_text() {
    local txtpdf; txtpdf="$1"
    local imgpdf; imgpdf="$2"
    local outpdf; outpdf="${3--}"
    if [ "-" != "${txtpdf}" ] && [ ! -f "${txtpdf}" ]; then echo "error: text PDF does not exist: ${txtpdf}" 1>&2; return 1; fi
    if [ "-" != "${imgpdf}" ] && [ ! -f "${imgpdf}" ]; then echo "error: image PDF does not exist: ${imgpdf}" 1>&2; return 1; fi
    if [ "-" != "${outpdf}" ] && [ -e "${outpdf}" ]; then echo "error: not overwriting existing output file: ${outpdf}" 1>&2; return 1; fi
    (
        local txtonlypdf; txtonlypdf="$(TMPDIR=. mktemp --suffix=.pdf)"
        trap "rm -f -- '${txtonlypdf//'/'\\''}'" EXIT
        gs -o "${txtonlypdf}" -sDEVICE=pdfwrite -dFILTERIMAGE "${txtpdf}"
        pdftk "${txtonlypdf}" multistamp "${imgpdf}" output "${outpdf}"
    )
}

pdf_merge_text "$@"
