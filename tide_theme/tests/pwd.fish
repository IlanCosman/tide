@mesg '-------------pwd-------------'

function _pwd -a dir
    cd $dir
    _tide_decolor (_tide_item_pwd)
end

# Dont forget that ~ doesn't expand to $HOME in quotes

# Unwritable directories

sudo mkdir -p ~/unwritable/dir # Uses sudo to make the dir unwritable

set -lx tide_pwd_unwritable_icon ''

@test '~/unwritable' (_pwd ~/unwritable) = ' ~/unwritable'
@test '~/unwritable/dir' (_pwd ~/unwritable/dir) = ' ~/unwritable/dir'

# No icon / directories

set -lx tide_pwd_unwritable_icon

@test '/' (_pwd '/') = '/'
@test '/usr' (_pwd '/usr') = '/usr'
@test '/usr/share' (_pwd '/usr/share') = '/usr/share'

# Normal directories

mkdir -p ~/normal/dir

@test '~' (_pwd ~) = '~'
@test '~/normal' (_pwd ~/normal) = '~/normal'
@test '~/normal/dir' (_pwd ~/normal/dir) = '~/normal/dir'

rm -rf ~/normal

# Long directories

set -l longDir ~/alfa/bravo/charlie/delta/echo/foxtrot/golf/hotel/inda/juliett/kilo/lima/mike/november/oscar/papa
mkdir -p $longDir

@test 'Long dir' (_pwd "$longDir") = '~/a/b/c/d/e/f/g/hotel/inda/juliett/kilo/lima/mike/november/oscar/papa'

rm -r ~/alfa