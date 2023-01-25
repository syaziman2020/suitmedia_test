import 'package:flutter/material.dart';
import 'package:suitmedia_app/cubit/identity_cubit.dart';
import 'package:suitmedia_app/pages/second_screen.dart';
import 'package:suitmedia_app/widgets/identity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/theme.dart';

class LastScreen extends StatefulWidget {
  const LastScreen({
    super.key,
    required this.name,
  });

  final String? name;

  @override
  State<LastScreen> createState() => _LastScreenState();
}

class _LastScreenState extends State<LastScreen> {
  final _scrollController = ScrollController();

  bool onLoad = false;
  @override
  void initState() {
    context.read<IdentityCubit>().getIdentityList(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteC,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: whiteC,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
          ),
        ),
        title: Text(
          'Third Screen',
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocConsumer<IdentityCubit, IdentityState>(
          listener: (context, state) {
            if (state is IdentityFailed) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'Terjadi kesalahan',
                    style: blackTextStyle,
                  ),
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is IdentitySuccess) {
              if (state.listIdentity!.isNotEmpty) {
                return NotificationListener(
                  onNotification: (ScrollNotification notification) {
                    return _handleScrollNotification(
                        scrollNotification: notification,
                        page: state.currentPage!,
                        amountPage: state.amountPage!);
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<IdentityCubit>().getIdentityList(1);
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          ...state.listIdentity!.map(
                            (e) => Identity(
                              url: '${e.avatar}',
                              name: '${e.firstName} ${e.lastName}',
                              email: '${e.email}',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SecondScreen(
                                      selectedName:
                                          '${e.firstName} ${e.lastName}',
                                      name: widget.name,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          (state.currentPage!) < (state.amountPage!)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                    ),
                                    const SizedBox(
                                      height: 100,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'Data Kosong',
                    style: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                    ),
                  ),
                );
              }
            } else if (state is IdentityLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  bool _handleScrollNotification({
    required ScrollNotification scrollNotification,
    required int page,
    required int amountPage,
  }) {
    // Check Scroll Position
    if (scrollNotification is ScrollEndNotification &&
        _scrollController.position.maxScrollExtent ==
            _scrollController.offset) {
      // Set More Loading = true

      if (onLoad == true) {
        return false;
      }
      onLoad = true;
      // More Posts
      if (page != amountPage) {
        page += 1;
        print('ini page $page');
        context.read<IdentityCubit>().refetchIdentityList(page).then(
          (value) {
            // Set More Loading = false
            onLoad = false;
            setState(() {});
          },
        );
      }
    }

    return false;
  }
}
