#!/bin/sh
[ "${TERM:-none}" = "linux" ] && \
    printf '%b' '\e]P0101010
                 \e]P1808081
                 \e]P2828385
                 \e]P3AEACA9
                 \e]P4CAC4B9
                 \e]P5D9D3C9
                 \e]P6E3DBD0
                 \e]P7f4eee4
                 \e]P8aaa69f
                 \e]P9808081
                 \e]PA828385
                 \e]PBAEACA9
                 \e]PCCAC4B9
                 \e]PDD9D3C9
                 \e]PEE3DBD0
                 \e]PFf4eee4
                 \ec'
