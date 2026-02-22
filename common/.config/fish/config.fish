if status is-interactive
	starship init fish | source

	function fish_greeting
	    echo ""
	    echo "  ██████╗ ██████╗ ██████╗ ███████╗"
	    echo "  ██╔════╝██╔═══██╗██╔══██╗██╔════╝"
	    echo "  ██║     ██║   ██║██║  ██║█████╗  "
	    echo "  ██║     ██║   ██║██║  ██║██╔══╝  "
	    echo "  ╚██████╗╚██████╔╝██████╔╝███████╗"
	    echo "   ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝"
	    echo ""
	    fastfetch --logo none --structure title:os:kernel:uptime --key-padding-left 5
	end
end
