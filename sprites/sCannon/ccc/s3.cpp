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
typedef tuple<ll, ll, int> pt;
template<typename T, typename X, class cmp = less<T>> using ordered_set = tree<T, X, less<T>, rb_tree_tag, tree_order_statistics_node_update>;
template<typename T, typename X> using hash_map = gp_hash_table<T, X>;
const int maxN = 2e5+1;

int n; ll p[maxN], w[maxN], d[maxN], slope; ll ans, val, pre; set<pt> pts;
int main() {
    cin.sync_with_stdio(0); cin.tie(0); sc(n);
    for(int i = 1; i <= n; i++) {
        sc(p[i], w[i], d[i]); slope -= w[i]; pts.insert({p[i]-d[i], w[i], 2*i}); pts.insert({p[i]+d[i], w[i], 2*i+1});
    }
    //keep track of the slop eof the line using line sweep, whenever slope changes find the min value
    //initially each one contributes -w[i] slope (from the left, u can move closer to reudce time
    //then in the middl eit's 0, then after it's positive
    //first, evaluate the function at -1e9
    pre = -2e9;
    for(int i = 1; i <= n; i++) {
        ans += (ll)(p[i]-pre-d[i])*(w[i]);
    }
    val = ans;
    //then, find different values of the function
    for(auto p : pts) {
        val += slope*(get<0>(p)-pre); ans = min(ans, val);
        slope += get<1>(p); pre = get<0>(p);
    }
    pr(ans, nl);
}