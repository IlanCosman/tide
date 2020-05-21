@mesg '-------------pwd-------------'

function _pwd -a dir
    cd $dir
    _tide_decolor (_tide_item_pwd)
end

set -l unwr "$tide_pwd_unwritable_icon "

@test '/' (_pwd '/') = $unwr'/ '
@test '/usr' (_pwd '/usr') = $unwr'/usr '
@test '/usr/share' (_pwd '/usr/share') = $unwr'/usr/share '
@test '~' (_pwd "$HOME") = '~ '
@test '~/.config' (_pwd "$HOME/.config") = '~/.config '
@test '~/.config/fish' (_pwd "$HOME/.config/fish") = '~/.config/fish '

set -l longDir "$HOME/alfa/bravo/charlie/delta/echo/foxtrot/golf/hotel/inda/juliett/kilo/lima/mike/november/oscar/papa"
if not test -e $longDir
    mkdir -p $longDir
end
@test 'Long dir' (_pwd "$longDir") = '~/a/b/c/d/e/f/golf/hotel/inda/juliett/kilo/lima/mike/november/oscar/papa '
rm -r $longDir