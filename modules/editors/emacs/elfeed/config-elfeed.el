
(setq elfeed-feeds
      '(
        ;; YouTube Feeds
        ("https://rsshub.app/youtube/user/@LukeSmithxyz" youtube)

        ;; News Feeds
        ("https://www.phoronix.com/rss.php" linux news hardware)
        ("https://www.cyberciti.com/atom/atom.xml" linux news)

        ;; Math Feeds
        ("https://terrytao.wordpress.com/feed/" math) ;; Terence Tao
        ("https://www.quantamagazine.org/tag/mathematics/feed/" math science) ;; Quanta Magazine
        ("https://jeremykun.com/feed/" math algorithms) ;; Math ∩ Programming
        ("https://www.quantamagazine.org/feed/" math science)
        ("https://eli.thegreenplace.net/feeds/all.atom.xml" math)

        ;; Embedded Feeds
        ("https://interrupt.memfault.com/feed.xml" embedded firmware) ;; Interrupt
        ("https://embeddedartistry.com/feed/" embedded) ;; Embedded Artistry
        ("https://porzechowski.github.io/blog/feed.xml" embedded)
        ("https://www.ganssle.com/blog/feed.rss" embedded)

        ;; Rust Feeds
        ("https://blog.rust-lang.org/feed.xml" rust lang) ;; Rust core blog
        ("https://this-week-in-rust.org/rss.xml" rust weekly) ;; TWiR
        ("https://fasterthanli.me/index.xml" rust tutorials) ;; fasterthanli.me

        ;; Systems Feeds
        ("https://nullprogram.com/feed/" c systems) ;; Null Program
        ("https://128nops.blogspot.com/rss.xml" pentesting)
        ("https://queue.acm.org/rss/feeds/queuecontent.xml" systems)
        ("https://andrewkelley.me/rss.xml" zig systems)
        ("https://priver.dev/blog/index.xml" systems rust functional ocaml)
        ("https://geohot.github.io/blog/feed.xml" systems singularity)
        ("https://www.rfleury.com/feed" cs systems)
        ("https://commandpattern.org/feed/" cs systems robotics)
        ("https://ludwigabap.bearblog.dev/feed/" cs systems ml)
        ("http://lesserwrong.com/feed.xml" systems AI singularity)
        ))


(provide 'config-elfeed)