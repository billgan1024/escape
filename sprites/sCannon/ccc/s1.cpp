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

int n; int h[10005]; int ans;
int main() {
    cin.sync_with_stdio(0); cin.tie(0); sc(n);
    for(int i = 1; i <= n+1; i++) sc(h[i]);
    for(int i = 1, x; i <= n; i++) {
        sc(x); ans += x*(h[i]+h[i+1]);
    }
    if(ans % 2 == 1) printf("%.1f", (double)ans/2.0);
    else pr(ans/2, nl);
}