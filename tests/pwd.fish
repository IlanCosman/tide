@mesg '-------------pwd-------------'

function _pwd -a dir
    cd $dir
    _tide_decolor (_tide_item_pwd)
end

# Unwritable directories

sudo mkdir -p /unwritable/dir

set -l unwr "$tide_pwd_unwritable_icon "

@test '/' (_pwd '/') = $unwr'/'
@test '/unwritable' (_pwd '/unwritable') = $unwr'/unwritable'
@test '/unwritable/dir' (_pwd '/unwritable/dir') = $unwr'/unwritable/dir'

sudo rm -rf /unwritable

# Normal directories

mkdir -p ~/normal/dir

@test '~' (_pwd ~) = '~'
@test '~/normal' (_pwd ~/normal) = '~/normal'
@test '~/normal/dir' (_pwd ~/normal/dir) = '~/normal/dir'

rm -rf ~/normal

# Long directories

set -l longDir "$HOME/alfa/bravo/charlie/delta/echo/foxtrot/golf/hotel/inda/juliett/kilo/lima/mike/november/oscar/papa"
mkdir -p $longDir

@test 'Long dir' (_pwd "$longDir") = '~/a/b/c/d/e/f/g/hotel/inda/juliett/kilo/lima/mike/november/oscar/papa'

rm -r ~/alfa