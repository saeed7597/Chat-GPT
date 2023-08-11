import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:iran_gpt/features/mian/domain/entites/save_data_entity.dart';
import 'package:iran_gpt/features/mian/domain/entites/value_object/main_params.dart';
import 'package:iran_gpt/features/mian/presentation/bloc/main_bloc.dart';
import '../../../../core/services/service_locator.dart';


const Color primaryColor = Color(0xff1A1924);
List<SaveDataEntity> allData = [];
bool isTyping = false;
ScrollController scrollController = ScrollController();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController contentController = TextEditingController();


  String _detectLanguage(String text) {
    // Implement a language detection algorithm here
    // For simplicity, let's assume any text containing Persian (Farsi) characters is in Persian language
    return text.contains(RegExp(r'[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F]')) ? 'fa' : 'en';
  }
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => sl<MainBloc>(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          context.read<MainBloc>().add(GetAllDataEvent());
          if (state is GetAllData) {
            allData = state.data;
          }
          if (state is DeleteHistory) {
            allData.clear();
          }
          if (state is SaveData) {
            scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut
            );
            if (contentController.text.isNotEmpty) {
              MainParams mainParams = MainParams(messages: [Messages(content: contentController.text)]);
              context.read<MainBloc>().add(SendDataEvent(mainParams));
              contentController.text = '';
            }
          }
          if (state is DoneData) {
            isTyping = false;
            SaveDataEntity data = SaveDataEntity(
                content: state.mainEntity.choices[0].message.content,
                created: state.mainEntity.created,
                fromIs: 0);
            saveDataInLocal(context, data);
          }
          return Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(
              backgroundColor: primaryColor,
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 4, 8),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: CircleAvatar(
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chat GPT',
                    style: themeData.textTheme.labelSmall!
                        .copyWith(color: Colors.white, fontSize: 18,fontFamily: 'Vazir'),
                  ),
                  Row(
                    children: [
                      isTyping
                          ? const SizedBox()
                          : Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        isTyping ? "is typing..." : 'Online',
                        style: themeData.textTheme.labelSmall!.copyWith(
                            color: isTyping ? Colors.blue : Colors.green,
                            fontSize: 15,fontFamily: 'Vazir'),
                      ),
                    ],
                  )
                ],
              ),
              actions: [
                IconButton(
                    onPressed: (){
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut
                        );
                      });
                      context.read<MainBloc>().add(DeleteAllHistoryEvent());
                    },
                    icon: const Icon(Icons.delete,color: Colors.white,)
                )
              ],
            ),
            body: SizedBox(
              width: width,
              height: height,
              child: Column(
                children: [
                  Expanded(child: ListView.builder(
                      controller: scrollController,
                      itemCount: allData.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (allData.isEmpty) {
                          return  Center(child: Text('Your data in empty',style: themeData.textTheme.labelLarge!.copyWith(color: Colors.white),),);
                        }else {
                          return Align(
                            alignment: allData[index].fromIs == 0
                                ? Alignment.topLeft
                                : Alignment.topRight,
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: allData[index].fromIs ==
                                      0
                                      ? const Color(0xff633BBC)
                                      : const Color(0xff07847E),
                                  borderRadius:
                                  BorderRadius.circular(8)),
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    12, 8, 8, 4),
                                child: Directionality(
                                    textDirection: _detectLanguage(allData[index].content) == 'en' ? TextDirection.ltr : TextDirection.rtl,
                                    child: Text(
                                  allData[index].content,
                                  style: themeData
                                      .textTheme.labelSmall!
                                      .copyWith(
                                      color: Colors.white,fontFamily: 'Vazir'),
                                ))
                              ),
                            ),
                          );
                        }
                      })),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xff282843),
                      ),
                      child: TextFormField(

                        textDirection: _detectLanguage(contentController.text) == 'en' ? TextDirection.ltr : TextDirection.rtl,
                        style: themeData.textTheme.labelSmall!
                            .copyWith(color: Colors.white,fontFamily: 'Vazir'),
                        controller: contentController,
                        onSaved: (content) {
                          SaveDataEntity data = SaveDataEntity(
                              content: contentController.text,
                              created: DateTime.now().millisecondsSinceEpoch,
                              fromIs: 1);
                          saveDataInLocal(context, data);
                          isTyping = true;
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Message",
                            suffixIcon: IconButton(
                              onPressed: () {
                                if(contentController.text.isNotEmpty) {
                                  scrollController.animateTo(
                                      scrollController.position.maxScrollExtent,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeOut
                                  );
                                  SaveDataEntity data = SaveDataEntity(
                                      content: contentController.text,
                                      created: DateTime.now().millisecondsSinceEpoch,
                                      fromIs: 1);
                                  saveDataInLocal(context, data);
                                  isTyping = true;
                                  FocusManager.instance.primaryFocus?.unfocus();
                                }else {

                                }

                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            hintStyle: themeData.textTheme.labelSmall!.copyWith(
                                color: Colors.white70, fontWeight: FontWeight.w300,fontFamily: 'Vazir'),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15)),
                      ),
                    ),
                  )
                ],
              ),
            )
          );
        },
      ),
    );
  }

  void saveDataInLocal(BuildContext context, SaveDataEntity dataEntity) {
    context.read<MainBloc>().add(SaveDataInDb(dataEntity));
  }
}



