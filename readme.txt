
  /\/\				           
 /  \ \                                  
/   /  \                       - syntaxIRC Readme File
\  /  \ \                      creator: abyss[abyss@cataclysm.net]
.\     \ \....___.._.....                         
: \    /\/\    |        :      [ greets] behemoth, noob, think, bonez, dwoo 
:  \  /   /\   :        :                daem0n, fracture, Chron, #syntax, #c0de
:  /\/   /  \  |__..._..:                \\StOrM\\, Waffles, hFz, arcane, ivy
| /  \  /   /\ :    :   |                BigElmer, webba, psykotyk, Mind, delphi
: \_  \    /  \:    :   |                         
|   \     /    \  /\:   |      [website] www.negative.net        
|    \   /   /  \/  \   :      [ftpsite] none                     
|_... \_/\  /   /    \  |                
:         \/   /    _/  :          
:     :    \  /     \   :                        
|     :.._..\/       \  |        
:     |      \    \  /  |       
:     :       \  / \/ \ :      
:.___.:.__.....\/   \  \:      
|        |      \  \ \  \     
|        :       \  \/  /\     
|        :       _\    / /                    
:        :       \ \  / //\                   
:.....___:._.._...\ \/  /  \          
            ohseven\  /     \
                    \/      /
                    /    \_/
                    \_    \
                      \   /
                       \_/


-------------------------------------------------------------------------------

  ( xx )                                        (      Table of Contents      )

    [#1] Script Loading Instructions 
    [#2] Troubleshooting
    [#3] Credits


-------------------------------------------------------------------------------

  ( #1 )                                        ( Script Loading Instructions )
  

 1. First time loading
    [#1] CLOSE XIRCON, if you have already opened it.
    [#2] Double click on the syntax.reg file to merge the appropriate xirc 
         settings into your registry.
    [#3] place syntax.tcl in the same dir as your xircon.exe file
    [#4] Run xircon.exe
    [#5] Hit the server connect button
    [#6] Type: /load syntax.tcl
    [#7] Type: /help
    [#8] Type: /tog

 2. Loading
    [#1] Type: /scripts -- to find any scripts you currently have running.
    [#2] Type: /unload <script> -- for each loaded script
    [#3] Type: /load syntax.tcl


-------------------------------------------------------------------------------

  ( #2 )                                         (       Troubleshooting      )


 1. q: Why do users nicknames appear like "<       > text text" ??
    a: You forgot to update your settings, see question #2. 

 2. q: When I load syntax, certain colors aren't set correctly.. whats wrong?
    a: You need to run the syntax.reg file thats included with your .zip to update
       xircons registry settings. Make sure xircon is CLOSED when you run it, 
       otherwise it'll have no effect. To run it, all you need to do is double click
       from the windows explorer (or right click and select 'merge').

 3. q: When I ban someone it only bans their nick.. whats going wrong?
    a: The user does not have an internal address listing. If you have `IAL 
       Update On Join' toggle active, this should not be a problem. Syntax gets
       a users address when they say text in a channel, message you, join, part,
       nickchange, kick someone, and basically any other way it can. When you 
       attempt a ban on someone that is not on the Inernal Address List, it bans 
       their nick only, because this is the only information syntax has about 
       that user.

 4. q: Why is my identd always 'syntax' instead of what I set in the server
       connect window?
    a: You need to set your ident through syntax by either typing /ident <id>
       or /tog id <id>. Syntax must use its own identd for running clones with
       random idents and other services.


-------------------------------------------------------------------------------

  ( #3 )                                         (           Credits          )


   All code in syntax was coded by abyss *EXCEPT* for the following...

    >> Ascii art by ohseven(readme ascii), hyperfuzz(intro logo), and 
        zerohour(almost everything else).
    >> The base for the duration procedure, which I borrowed from behemoth.
    >> The replace procedure was coded and debuged by both me and behemoth.
   
   My personal thanks to noob, mind, behemoth, and dtm for helping me with my 
   dumb questions =)

   The following people have mental trauma:

          TBaur - Little dalnet kid that thinks he's hot shit because he runs 
                  a server.

   phiberoptics - Another retarded dalnetter(do we see a trend here?) with too
                  much ego and too little skill.

   EOF