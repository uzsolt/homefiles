#!/bin/sh

. ~/.config/herbstluftwm/include.sh 

# rules
hc unrule -F
#hc rule class=XTerm tag=3 # move all xterms to tag 3
hc rule focus=true # normally do not focus new clients

hc rule class="Conky" manage=off
hc rule class=KeepassX pseudotile=on
hc rule class~'(.*[Rr]xvt.*|.*[Tt]erm|Konsole)' focus=on

hc rule \
    instance=FreeBSD class=URxvt \
    tag=bsd switchtag=on
hc rule \
    instance=torrent class=URxvt \
    tag=torrent focus=false
hc rule \
    instance=Navigator class=Firefox \
    tag=web
hc rule \
    instance=RSS class=URxvt\
    tag=rss focus=false
hc rule \
    instance=Liferea\
    tag=rss focus=false
hc rule \
    instance=devel class=URxvt \
    tag=dev switchtag=on

hc rule \
    instance=dox class=URxvt \
    tag=dox index=0 switchtag=on
hc rule \
    class=Latex-viewer \
    tag=dox index=1 focus=false

hc rule \
    class=LibreOffice \
    tag=lo
hc rule \
    class=libreoffice-writer \
    tag=lowr
hc rule \
    class=libreoffice-calc \
    tag=lowr
hc rule \
    class=soffice \
    tag=loim

hc rule \
    class=qmpdclient\
    tag=music

hc rule windowtype='_NET_WM_WINDOW_TYPE_DIALOG' focus=on
hc rule windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)' pseudotile=on
hc rule windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK)' manage=off

