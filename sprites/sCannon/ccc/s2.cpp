#include <bits/stdc++.h>
#include <ext/pb_ds/assoc_container.hpp>

using namespace __gnu_pbds;
using namespace std;
#define nl '\n'
#define pb push_back
#define ms(x, y) memset(x, y, sizeof(x))
#define sp ' '
#define sz(x) (int)x.size()
void sc() {}
template<class T, class...A>
void sc(T &t, A &...a) { cin >> t, sc(a...); }
void pr() {}
template<class T, class...A>
void pr(T t, A...a) { cout << t, pr(a...); }

typedef long long ll;
typedef pair<int, int> pii;
template<typename T, typename X, class cmp = less<T>> using ordered_set = tree<T, X, less<T>, rb_tree_tag, tree_order_statistics_node_update>;
template<typename T, typename X> using hash_map = gp_hash_table<T, X>;
const int maxN = 5e6+1;

int n, m, k; bool row[maxN], col[maxN]; int r, c;
int main() {
    cin.sync_with_stdio(0); cin.tie(0); sc(n, m, k);
    for(int i =0; i < k; i++){
        char cmd; int x;
        sc(cmd, x);
        if(cmd == 'R') row[x] = !row[x];
        else col[x] = !col[x];
    }
    //for every row and col that's active, the answer is (N-r)(M-c)
    for(int i = 1; i <= n; i++) { r += row[i]; }
    for(int i = 1; i <= m; i++) { c += col[i]; }
    pr((ll)(n*m) - (ll)(n-r)*(m-c) - (ll)(r*c), nl);
}