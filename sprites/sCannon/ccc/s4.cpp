#include <bits/stdc++.h>
#include <ext/pb_ds/assoc_container.hpp>

using namespace __gnu_pbds;
using namespace std;
#define nl '\n'
#define pb push_back
#define ms(x, y) memset(x, y, sizeof(x))
#define sp ' '
#define sz(x) (int)x.size()
#define INF 0x3f
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
const int maxN = 2e5+1;

int n, w, d, path[maxN], dis[maxN]; queue<int> q; vector<int> adj[maxN]; int bit[maxN];
void upd(int idx, int val) {
    for(int i = idx; i < maxN; i += i&-i) bit[i] = min(bit[i], val);
}
int query(int idx) {
    int ret = INT_MAX;
    for(int i = idx; i > 0; i -= i&-i) ret = min(ret, bit[i]);
    return ret;
}
int main() {
    cin.sync_with_stdio(0); cin.tie(0); sc(n, w, d);
    ms(bit, INF);
    for(int i = 0, a, b; i < w; i++) {
        sc(a, b); adj[a].pb(b);
    }
    for(int i = 1; i <= n; i++) sc(path[i]);
    dis[n] = 0; q.push(n);
    while(!q.empty()) {
        int cur = q.front(); q.pop();
        for(int nxt : adj[cur]) {
            if(dis[nxt] > dis[cur]+1) {
                dis[nxt] = dis[cur]+1; q.push(nxt);
            }
        }
    }
        //if you can't get there, you need to take the train
        int tm = 0;
        for(int j = 1; j <= n; j++) { if(path[j] == n) { tm = j-1; break; } }
        int ans = INT_MAX;
        //choose a time to disengage from the train
        //if you need to wait for the train to come to a particular index,
        //it's no better than taking the train
        for(int i = 0; i <= tm; i++) {
            //disengage at time i
            upd(i+1, i+dis[path[i+1]]);
        }
        pr(ans, nl);
    for(int t = 1, x, y; t <= d; t++) {
        sc(x, y);
        if(x == tm) { tm = y; }
        if(y == tm) tm = x;
        pr(query(tm), nl);
    }
}