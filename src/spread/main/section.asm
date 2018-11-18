* Spreadsheet                                         06/03-92
*        - section control

         section  prog

         include  win1_keys_wman
         include  win1_keys_wstatus
         include  win1_keys_wwork

         xdef     sec_fitx,sec_fity

*+++
* update x-control block record, that n-th section fits into it
*
*                 Entry                      Exit
*        D0       section number             preserved
*        A3       appl. subwindow defn       preserved
*        A4       wwork                      preserved
*        A6       data area                  preserved
*---
r_fitx
sec_fitx
         movem.l  r_fitx,-(sp)
         move.w   mcx_grid+wss_nsec(a6),d4   ; total number of sections
         subq.w   #1,d4
         cmp.w    d0,d4
         mulu     #wss.ssln,d0               ; section status list entry
