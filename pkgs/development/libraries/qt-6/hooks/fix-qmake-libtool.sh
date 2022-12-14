# Fix libtool libraries generated by qmake.
# qmake started inserting filenames of shared objects instead of the appropriate
# linker flags. fixQmakeLibtool searches for broken libtool libraries and
# replaces the filenames with the linker flags that should have been there.
fixQmakeLibtool() {
    if [ -d "$1" ]; then
        find "$1" -name '*.la' | while read la; do
            set +e
            framework_libs=$(grep '^dependency_libs' "$la" | grep -Eo -- '-framework +\w+' | tr '\n' ' ')
            set -e
            sed -i "$la" \
                -e '/^dependency_libs/ s,\(/[^ ]\+\)/lib\([^/ ]\+\)\.so,-L\1 -l\2,g' \
                -e '/^dependency_libs/ s,-framework \+\w\+,,g'
            if [ ! -z "$framework_libs" ]; then
                if grep '^inherited_linker_flags=' $la >/dev/null; then
                    sed -i "$la" -e "s/^\(inherited_linker_flags='[^']*\)/\1 $framework_libs/"
                else
                    echo "inherited_linker_flags='$framework_libs'" >>"$la"
                fi
            fi
        done
    fi
}

fixupOutputHooks+=('fixQmakeLibtool $prefix')
