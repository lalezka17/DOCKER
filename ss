[4mSS[24m(8)                                                                         System Manager's Manual                                                                         [4mSS[24m(8)

[1mNAME[0m
       ss - another utility to investigate sockets

[1mSYNOPSIS[0m
       [1mss [22m[[4moptions[24m] [4m[[24m [4mFILTER[24m [4m][0m

[1mDESCRIPTION[0m
       [1mss [22mis used to dump socket statistics. It allows showing information similar to [4mnetstat[24m.  It can display more TCP and state information than other tools.

[1mOPTIONS[0m
       When no option is used ss displays a list of open non-listening sockets (e.g. TCP/UNIX/UDP) that have established connection.

       [1m-h, --help[0m
              Show summary of options.

       [1m-V, --version[0m
              Output version information.

       [1m-H, --no-header[0m
              Suppress header line.

       [1m-O, --oneline[0m
              Print each socket's data on a single line.

       [1m-n, --numeric[0m
              Do not try to resolve service names. Show exact bandwidth values, instead of human-readable.

       [1m-r, --resolve[0m
              Try to resolve numeric address/ports.

       [1m-a, --all[0m
              Display both listening and non-listening (for TCP this means established connections) sockets.

       [1m-l, --listening[0m
              Display only listening sockets (these are omitted by default).

       [1m-o, --options[0m
              Show timer information. For TCP protocol, the output format is:

              timer:(<timer_name>,<expire_time>,<retrans>)

              [1m<timer_name>[0m
                     the name of the timer, there are five kind of timer names:

                     [1mon [22m: means one of these timers: TCP retrans timer, TCP early retrans timer and tail loss probe timer

                     [1mkeepalive[22m: tcp keep alive timer

                     [1mtimewait[22m: timewait stage timer

                     [1mpersist[22m: zero window probe timer

                     [1munknown[22m: none of the above timers

              [1m<expire_time>[0m
                     how long time the timer will expire

              [1m<retrans>[0m
                     how many times the retransmission occurred

       [1m-e, --extended[0m
              Show detailed socket information. The output format is:

              uid:<uid_number> ino:<inode_number> sk:<cookie>

              [1m<uid_number>[0m
                     the user id the socket belongs to

              [1m<inode_number>[0m
                     the socket's inode number in VFS

              [1m<cookie>[0m
                     an uuid of the socket

       [1m-m, --memory[0m
              Show socket memory usage. The output format is:

              skmem:(r<rmem_alloc>,rb<rcv_buf>,t<wmem_alloc>,tb<snd_buf>,
                            f<fwd_alloc>,w<wmem_queued>,o<opt_mem>,
                            bl<back_log>,d<sock_drop>)

              [1m<rmem_alloc>[0m
                     the memory allocated for receiving packet

              [1m<rcv_buf>[0m
                     the total memory can be allocated for receiving packet

              [1m<wmem_alloc>[0m
                     the memory used for sending packet (which has been sent to layer 3)

              [1m<snd_buf>[0m
                     the total memory can be allocated for sending packet

              [1m<fwd_alloc>[0m
                     the  memory  allocated  by the socket as cache, but not used for receiving/sending packet yet. If need memory to send/receive packet, the memory in this cache
                     will be used before allocate additional memory.

              [1m<wmem_queued>[0m
                     The memory allocated for sending packet (which has not been sent to layer 3)

              [1m<opt_mem>[0m
                     The memory used for storing socket option, e.g., the key for TCP MD5 signature

              [1m<back_log>[0m
                     The memory used for the sk backlog queue. On a process context, if the process is receiving packet, and a new packet is received, it will be put into  the  sk
                     backlog queue, so it can be received by the process immediately

              [1m<sock_drop>[0m
                     the number of packets dropped before they are de-multiplexed into the socket

       [1m-p, --processes[0m
              Show process using socket.

       [1m-T, --threads[0m
              Show thread using socket. Implies -p.  [1m-p[22m.

       [1m-i, --info[0m
              Show internal TCP information. Below fields may appear:

              [1mts     [22mshow string "ts" if the timestamp option is set

              [1msack   [22mshow string "sack" if the sack option is set

              [1mecn    [22mshow string "ecn" if the explicit congestion notification option is set

              [1mecnseen[0m
                     show string "ecnseen" if the saw ecn flag is found in received packets

              [1mfastopen[0m
                     show string "fastopen" if the fastopen option is set

              [1mcong_alg[0m
                     the congestion algorithm name, the default congestion algorithm is "cubic"

              [1mwscale:<snd_wscale>:<rcv_wscale>[0m
                     if window scale option is used, this field shows the send scale factor and receive scale factor

              [1mrto:<icsk_rto>[0m
                     tcp re-transmission timeout value, the unit is millisecond

              [1mbackoff:<icsk_backoff>[0m
                     used for exponential backoff re-transmission, the actual re-transmission timeout value is icsk_rto << icsk_backoff

              [1mrtt:<rtt>/<rttvar>[0m
                     rtt is the average round trip time, rttvar is the mean deviation of rtt, their units are millisecond

              [1mato:<ato>[0m
                     ack timeout, unit is millisecond, used for delay ack mode

              [1mmss:<mss>[0m
                     max segment size

              [1mcwnd:<cwnd>[0m
                     congestion window size

              [1mpmtu:<pmtu>[0m
                     path MTU value

              [1mssthresh:<ssthresh>[0m
                     tcp congestion window slow start threshold

              [1mbytes_acked:<bytes_acked>[0m
                     bytes acked

              [1mbytes_received:<bytes_received>[0m
                     bytes received

              [1msegs_out:<segs_out>[0m
                     segments sent out

              [1msegs_in:<segs_in>[0m
                     segments received

              [1msend <send_bps>bps[0m
                     egress bps

              [1mlastsnd:<lastsnd>[0m
                     how long time since the last packet sent, the unit is millisecond

              [1mlastrcv:<lastrcv>[0m
                     how long time since the last packet received, the unit is millisecond

              [1mlastack:<lastack>[0m
                     how long time since the last ack received, the unit is millisecond

              [1mpacing_rate <pacing_rate>bps/<max_pacing_rate>bps[0m
                     the pacing rate and max pacing rate

              [1mrcv_space:<rcv_space>[0m
                     a helper variable for TCP internal auto tuning socket receive buffer

              [1mtcp-ulp-mptcp flags:[MmBbJjecv] token:<rem_token(rem_id)/loc_token(loc_id)> seq:<sn> sfseq:<ssn> ssnoff:<off> maplen:<maplen>[0m
                     MPTCP subflow information

       [1m--tos  [22mShow ToS and priority information. Below fields may appear:

              [1mtos    [22mIPv4 Type-of-Service byte

              [1mtclass [22mIPv6 Traffic Class byte

              [1mclass_id[0m
                     Class id set by net_cls cgroup. If class is zero this shows priority set by SO_PRIORITY.

       [1m--cgroup[0m
              Show cgroup information. Below fields may appear:

              [1mcgroup [22mCgroup v2 pathname. This pathname is relative to the mount point of the hierarchy.

       [1m--tipcinfo[0m
              Show internal tipc socket information.

              [1m-K, --kill[0m
                     Attempts  to  forcibly  close  sockets.  This option displays sockets that are successfully closed and silently skips sockets that the kernel does not support
                     closing. It supports IPv4 and IPv6 sockets only.

              [1m-s, --summary[0m
                     Print summary statistics. This option does not parse socket lists obtaining summary from various sources. It is useful when amount of sockets is so huge  that
                     parsing /proc/net/tcp is painful.

              [1m-E, --events[0m
                     Continually display sockets as they are destroyed

              [1m-Z, --context[0m
                     As the [1m-p [22moption but also shows process security context. If the [1m-T [22moption is used, also shows thread security context.

                     For [1mnetlink[22m(7) sockets the initiating process context is displayed as follows:

                            1.  If valid pid show the process context.

                            2.  If destination is kernel (pid = 0) show kernel initial context.

                            3.  If a unique identifier has been allocated by the kernel or netlink user, show context as "unavailable". This will generally indicate that a process
                                has more than one netlink socket active.

              [1m-z, --contexts[0m
                     As  the  [1m-Z  [22moption  but also shows the socket context. The socket context is taken from the associated inode and is not the actual socket context held by the
                     kernel. Sockets are typically labeled with the context of the creating process, however the context shown will reflect any  policy  role,  type  and/or  range
                     transition rules applied, and is therefore a useful reference.

              [1m-N NSNAME, --net=NSNAME[0m
                     Switch to the specified network namespace name.

              [1m-b, --bpf[0m
                     Show socket classic BPF filters (only administrators are allowed to get these information).

              [1m-4, --ipv4[0m
                     Display only IP version 4 sockets (alias for -f inet).

              [1m-6, --ipv6[0m
                     Display only IP version 6 sockets (alias for -f inet6).

              [1m-0, --packet[0m
                     Display PACKET sockets (alias for -f link).

              [1m-t, --tcp[0m
                     Display TCP sockets.

              [1m-u, --udp[0m
                     Display UDP sockets.

              [1m-d, --dccp[0m
                     Display DCCP sockets.

              [1m-w, --raw[0m
                     Display RAW sockets.

              [1m-x, --unix[0m
                     Display Unix domain sockets (alias for -f unix).

              [1m-S, --sctp[0m
                     Display SCTP sockets.

              [1m--tipc [22mDisplay tipc sockets (alias for -f tipc).

              [1m--vsock[0m
                     Display vsock sockets (alias for -f vsock).

              [1m--xdp  [22mDisplay XDP sockets (alias for -f xdp).

              [1m-M, --mptcp[0m
                     Display MPTCP sockets.

              [1m--inet-sockopt[0m
                     Display inet socket options.

              [1m-f FAMILY, --family=FAMILY[0m
                     Display sockets of type FAMILY.  Currently the following families are supported: unix, inet, inet6, link, netlink, vsock, tipc, xdp.

              [1m-A QUERY, --query=QUERY, --socket=QUERY[0m
                     List  of  socket  tables  to dump, separated by commas. The following identifiers are understood: all, inet, tcp, udp, raw, unix, packet, netlink, unix_dgram,
                     unix_stream, unix_seqpacket, packet_raw, packet_dgram, dccp, sctp, tipc, vsock_stream, vsock_dgram, xdp, mptcp. Any item in the list may  optionally  be  pre‐
                     fixed by an exclamation mark ([1m![22m)  to exclude that socket table from being dumped.

              [1m-D FILE, --diag=FILE[0m
                     Do not display anything, just dump raw information about TCP sockets to FILE after applying filters. If FILE is - stdout is used.

              [1m-F FILE, --filter=FILE[0m
                     Read filter information from FILE.  Each line of FILE is interpreted like single command line option. If FILE is - stdin is used.

              [1mFILTER := [ state STATE-FILTER ] [ EXPRESSION ][0m
                     Please take a look at the official documentation for details regarding filters.

[1mSTATE-FILTER[0m
       [1mSTATE-FILTER [22mallows one to construct arbitrary set of states to match. Its syntax is sequence of keywords state and exclude followed by identifier of state.

       Available identifiers are:

              All standard TCP states: [1mestablished[22m, [1msyn-sent[22m, [1msyn-recv[22m, [1mfin-wait-1[22m, [1mfin-wait-2[22m, [1mtime-wait[22m, [1mclosed[22m, [1mclose-wait[22m, [1mlast-ack[22m, [1mlistening [22mand [1mclosing.[0m

              [1mall [22m- for all the states

              [1mconnected [22m- all the states except for [1mlistening [22mand [1mclosed[0m

              [1msynchronized [22m- all the [1mconnected [22mstates except for [1msyn-sent[0m

              [1mbucket [22m- states, which are maintained as minisockets, i.e.  [1mtime-wait [22mand [1msyn-recv[0m

              [1mbig [22m- opposite to [1mbucket[0m

[1mEXPRESSION[0m
       [1mEXPRESSION  [22mallows  filtering based on specific criteria.  [1mEXPRESSION [22mconsists of a series of predicates combined by boolean operators. The possible operators in increasing
       order of precedence are [1mor [22m(or | or ||), [1mand [22m(or & or &&), and [1mnot [22m(or !). If no operator is between consecutive predicates, an implicit [1mand [22moperator is assumed. Subexpres‐
       sions can be grouped with "(" and ")".

       The following predicates are supported:

       [1m{dst|src} [=] HOST[0m
              Test if the destination or source matches HOST. See HOST SYNTAX for details.

       [1m{dport|sport} [OP] [FAMILY:]:PORT[0m
              Compare the destination or source port to PORT. OP can be any of "<", "<=", "=", "!=", ">=" and ">". Following normal arithmetic rules. FAMILY and PORT  are  as  de‐
              scribed in HOST SYNTAX below.

       [1mdev [=|!=] DEVICE[0m
              Match based on the device the connection uses. DEVICE can either be a device name or the index of the interface.

       [1mfwmark [=|!=] MASK[0m
              Matches  based  on the fwmark value for the connection. This can either be a specific mark value or a mark value followed by a "/" and a bitmask of which bits to use
              in the comparison. For example "fwmark = 0x01/0x03" would match if the two least significant bits of the fwmark were 0x01.

       [1mcgroup [=|!=] PATH[0m
              Match if the connection is part of a cgroup at the given path.

       [1mautobound[0m
              Match if the port or path of the source address was automatically allocated (rather than explicitly specified).

       Most operators have aliases. If no operator is supplied "=" is assumed.  Each of the following groups of operators are all equivalent:

              • = == eq

              • != ne neq

              • > gt

              • < lt

              • >= ge geq

              • <= le leq

              • ! not

              • | || or

              • & && and

[1mHOST SYNTAX[0m
       The general host syntax is [FAMILY:]ADDRESS[:PORT].

       FAMILY must be one of the families supported by the -f option. If not given it defaults to the family given with the -f option, and if that is also missing, will assume ei‐
       ther inet or inet6. Note that all host conditions in the expression should either all be the same family or be only inet and inet6. If there is some other mixture of  fami‐
       lies, the results will probably be unexpected.

       The form of ADDRESS and PORT depends on the family used. "*" can be used as a wildcard for either the address or port. The details for each family are as follows:

       [1munix   [22mADDRESS  is  a  glob  pattern (see [1mfnmatch[22m(3)) that will be matched case-insensitively against the unix socket's address. Both path and abstract names are supported.
              Unix addresses do not support a port, and "*" cannot be used as a wildcard.

       [1mlink   [22mADDRESS is the case-insensitive name of an Ethernet protocol to match. PORT is either a device name or a device index for the desired link device,  as  seen  in  the
              output of ip link.

       [1mnetlink[0m
              ADDRESS is a descriptor of the netlink family. Possible values come from /etc/iproute2/nl_protos. PORT is the port id of the socket, which is usually the same as the
              owning process id. The value "kernel" can be used to represent the kernel (port id of 0).

       [1mvsock  [22mADDRESS is an integer representing the CID address, and PORT is the port.

       [1minet [22mand [1minet6[0m
              ADDRESS  is an ip address (either v4 or v6 depending on the family) or a DNS hostname that resolves to an ip address of the required version. An ipv6 address must be
              enclosed in "[" and "]" to disambiguate the port separator. The address may additionally have a prefix length given in CIDR notation (a slash followed by the  prefix
              length in bits). PORT is either the numerical socket port, or the service name for the port to match.

[1mUSAGE EXAMPLES[0m
       [1mss -t -a[0m
              Display all TCP sockets.

       [1mss -t -a -Z[0m
              Display all TCP sockets with process SELinux security contexts.

       [1mss -u -a[0m
              Display all UDP sockets.

       [1mss -o state established '( dport = :ssh or sport = :ssh )'[0m
              Display all established ssh connections.

       [1mss -x src /tmp/.X11-unix/*[0m
              Find all local processes connected to X server.

       [1mss -o state fin-wait-1 '( sport = :http or sport = :https )' dst 193.233.7/24[0m
              List all the tcp sockets in state FIN-WAIT-1 for our apache to network 193.233.7/24 and look at their timers.

       [1mss -a -A 'all,!tcp'[0m
              List sockets in all states from all socket tables but TCP.

[1mSEE ALSO[0m
       [1mip[22m(8),
       [1mRFC [22m793 - https://tools.ietf.org/rfc/rfc793.txt (TCP states)

[1mAUTHOR[0m
       [4mss[24m was written by Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>.

       This manual page was written by Michael Prokop <mika@grml.org> for the Debian project (but may be used by others).

                                                                                                                                                                              [4mSS[24m(8)
