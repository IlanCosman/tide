function test_pwd
    set -l dB (set_color $lean_color_dark_blue)
    set -l lB (set_color -o $lean_color_light_blue)
    set -l l (set_color $lean_color_lilac)
    set -l n (set_color normal)

    set -l unwr $dB"$lean_pwd_unwritable_icon "$n

    echo 'Please perform a visual inspection.'
    echo '------------'
    echo 'OUTPUT'
    echo 'ANSWER'
    echo '------------'
    _comparePwd '/' (_joinSlash $unwr '')
    _comparePwd '/usr' (_joinSlash $unwr $lB'usr')
    _comparePwd '/usr/share' (_joinSlash $unwr $lB'usr' $lB'share')
    _comparePwd '/usr/share/fish' (_joinSlash $unwr $lB'usr' $dB'share' $lB'fish')

    _comparePwd "$HOME" (_joinSlash $lB'~')
    _comparePwd "$HOME/.config" (_joinSlash $lB'~' $lB'.config')
    _comparePwd "$HOME/.config/fish" (_joinSlash $lB'~' $dB'.config' $lB'fish')

    set -l longDir "$HOME/alfa/bravo/charlie/delta/echo/foxtrot/golf/hotel/inda/juliett/kilo/lima/mike/november/oscar/papa"
    set -l longDirAnswerLilac $l{'a','b','c','d','e','f'}
    set -l longDirAnswerDarkBlue $dB{'golf','hotel','inda','juliett','kilo','lima','mike','november','oscar'}
    set -l longDirAnswer (_joinSlash $lB'~' $longDirAnswerLilac $longDirAnswerDarkBlue $lB'papa')
    if not test -e $longDir
        mkdir -p $longDir
    end
    _comparePwd $longDir $longDirAnswer
    rm -r $longDir
end

function _comparePwd -a dir answer
    cd $dir
    echo (lean_pwd)
    echo $answer
end

function _joinSlash
    set -l slash (set_color $lean_color_dark_blue)'/'(set_color normal)
    string join $slash {$argv}(set_color normal)
end