#!/usr/bin/env bash
arr[1]=32
arr[2]=64
sum='195a30a1d1561cbc0ae7c488b93d037f6b713354'
str='Base{32,64}_Is_Stupid_But_Sometimes_Useful'
for i in $(seq 1 2); do
   for j in $(seq 1 2); do
      for k in $(seq 1 2); do
         for m in $(seq 1 2); do
            for n in $(seq 1 2); do
               tmp=$(echo "$str" | \
               base${arr[i]} | \
               base${arr[j]} | \
               base${arr[k]} | \
               base${arr[m]} | \
               base${arr[n]} | \
               sha1sum)
               val=$(echo "$tmp" | fgrep -o "$sum")
               if [ ! -z "$val" ]; then
                  printf "base%s -> base%s -> base%s -> base%s -> base%s -> %s\n" "${arr[i]}" "${arr[j]}" "${arr[k]}" "${arr[m]}" "${arr[n]}" "$val"
               fi
            done
         done
      done
   done
done

