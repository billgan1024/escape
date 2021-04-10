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
const int maxN = 1.5e5+1;

struct condition {
    int z, l, r;
};
bool cmp(condition x, condition y) { return x.z > y.z; }
int n, m, ans[maxN]; condition c[maxN];
int main() {
    cin.sync_with_stdio(0); cin.tie(0); sc(n, m);
    for(int i = 1; i <= m; i++) sc(c[i].l, c[i].r, c[i].z);
    sort(c+1, c+m+1, cmp);
    int cur = 1;
    while(cur <= m) {
        if(c[cur].z == 1) break;
        for(int i = c[cur].l; i <= c[cur].r; i++) ans[i] = 2;
        cur++;
    }
    while(cur <= m) {
        bool flag = false;
        for(int i = c[cur].l; i <= c[cur].r; i++) {
            if(ans[i] != 2) { ans[i] = 1; flag = true; break; }
        }
        if(!flag) { pr("Impossible", nl); return 0; }
        cur++;
    }
    for(int i = 1; i <= n; i++) pr(ans[i] == 0 ? 1 : ans[i], sp);
}