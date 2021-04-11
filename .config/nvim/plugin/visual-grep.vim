" reference: https://stackoverflow.com/a/26544046

function! Ilist_qf(selection, start_at_cursor)

    " there's a file associated with this buffer
    if len(expand('%')) > 0

        " we are working with visually selected text
        if a:selection

            " we build a clean search pattern from the visual selection
            let old_reg = @v
            normal! gv"vy
            let search_pattern = substitute(escape(@v, '\/.*$^~[]'), '\\n', '\\n', 'g')
            let @v = old_reg

            " and we redirect the output of our command for later use
            redir => output
                silent! execute (a:start_at_cursor ? '+,$' : '') . 'ilist /' . search_pattern
            redir END

        " we are working with the word under the cursor
        else

            " we redirect the output of our command for later use
            redir => output
                silent! execute 'normal! ' . (a:start_at_cursor ? ']' : '[') . "I"
            redir END
        endif
        let lines = split(output, '\n')

        " better safe than sorry
        if lines[0] =~ '^Error detected'
            echomsg 'Could not find "' . (a:selection ? search_pattern : expand("<cword>")) . '".'
            return
        endif

        " we retrieve the filename
        let [filename, line_info] = [lines[0], lines[1:-1]]

        " we turn the :ilist output into a quickfix dictionary
        let qf_entries = map(line_info, "{
                    \ 'filename': filename,
                    \ 'lnum': split(v:val)[1],
                    \ 'text': getline(split(v:val)[1])
                    \ }")
        call setqflist(qf_entries)

        " and we finally open the quickfix window if there's something to show
        cwindow

    " there's no file associated with this buffer
    else

        " we are working with visually selected text
        if a:selection

            " we build a clean search pattern from the visual selection
            let old_reg = @v
            normal! gv"vy
            let search_pattern = substitute(escape(@v, '\/.*$^~[]'), '\\n', '\\n', 'g')
            let @v = old_reg

            " and we try to perform the search
            try
                execute (a:start_at_cursor ? '+,$' : '') . 'ilist /' .  search_pattern . '<CR>:'
            catch
                echomsg 'Could not find "' . search_pattern . '".'
                return
            endtry

        " we are working with the word under the cursor
        else

            " we try to perform the search
            try
                execute 'normal! ' . (a:start_at_cursor ? ']' : '[') . "I"
            catch
                echomsg 'Could not find "' . expand("<cword>") . '".'
                return
            endtry
        endif
    endif
endfunction

xnoremap <silent> Q :<C-u>call Ilist_qf(1, 0)<CR>
