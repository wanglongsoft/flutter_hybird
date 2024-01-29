import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_module/component/expandable_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bruno/bruno.dart';

class BrunoComponent extends StatefulWidget {
  const BrunoComponent({super.key});

  @override
  State<BrunoComponent> createState() => _BrunoComponentState();
}

class _BrunoComponentState extends State<BrunoComponent> {
  BrnSearchTextController _searchController = BrnSearchTextController();
  TextEditingController _textController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(searchControllerCallBack);
    _textController.addListener(textControllerCallBack);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    BrnPortraitRadioGroupOption selectedValue;
    //屏幕适配初始化
    ScreenUtil.init(context, designSize: const Size(390, 844));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: <Widget>[
          SizedBox(
            width: ScreenUtil().setWidth(78),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              splashRadius: 25,
              onPressed: () {
                BoostNavigator.instance.pop();
              },
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(234),
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
                // 设置颜色无效
                textStyle:
                MaterialStateProperty.all(const TextStyle(fontSize: 18)),

                foregroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                    if (states.contains(MaterialState.pressed)) {
                      ////按下时的颜色
                      return Colors.black;
                    }
                    //默认状态使用灰色
                    return Colors.black;
                  },
                ),

                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  //设置按下时的背景颜色
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.white;
                  }
                  //默认不使用背景颜色
                  return Colors.white;
                }),
              ),
              onPressed: () {},
              child: const Text(
                "Bruno组件库",
                style: TextStyle(color: Color(0xFF000000)),
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(78),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(12),
                top: ScreenUtil().setWidth(12)),
            child: Container(
              width: ScreenUtil().setWidth(366),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
              ),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(16),
                          right: ScreenUtil().setWidth(16),
                          top: ScreenUtil().setWidth(16),
                          bottom: ScreenUtil().setWidth(16)),
                      child: SizedBox(
                        width: ScreenUtil().setWidth(334),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          runSpacing: ScreenUtil().setWidth(10),
                          children: [
                            BrnBigGhostButton(
                              width: ScreenUtil().setWidth(150),
                              title: '滑动式对话框',
                              onTap: () {
                                _showScrollDialog();
                              },
                            ),
                            BrnBigGhostButton(
                              width: ScreenUtil().setWidth(150),
                              title: '底部菜单',
                              onTap: () {
                                _showBottomDialog();
                              },
                            ),
                            BrnBigGhostButton(
                              width: ScreenUtil().setWidth(150),
                              title: '日期选择器',
                              onTap: () {
                                _showDatePicker();
                              },
                            ),
                            BrnBigGhostButton(
                              width: ScreenUtil().setWidth(150),
                              title: '多选底部弹框',
                              onTap: () {
                                _showMultiSelectListPicker();
                              },
                            ),
                          ],
                        ),
                      )),
                  BrnExpandableGroup(
                    title: "可展开收起表单项目",
                    themeData: BrnFormItemConfig(
                        headTitleTextStyle: BrnTextStyle(
                          fontSize: ScreenUtil().setSp(16),
                        )),
                    children: [
                      BrnTextInputFormItem(
                        title: "小米",
                        hint: "请输入",
                        onChanged: (newValue) {
                          BrnToast.show(
                              "点击触发回调_${newValue}_onChanged", context);
                        },
                      ),
                      BrnTextInputFormItem(
                        title: "OPPO",
                        hint: "请输入",
                        onChanged: (newValue) {
                          BrnToast.show(
                              "点击触发回调_${newValue}_onChanged", context);
                        },
                      ),
                      BrnTextInputFormItem(
                        title: "Vivo",
                        hint: "请输入",
                        onChanged: (newValue) {
                          BrnToast.show(
                              "点击触发回调_${newValue}_onChanged", context);
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(16),
                        right: ScreenUtil().setWidth(16)),
                    child: BrnNoticeBar(
                      content: '金樽清酒斗十千，玉盘珍羞直万钱。'
                          '停杯投箸不能食，拔剑四顾心茫然。'
                          '欲渡黄河冰塞川，将登太行雪满山。'
                          '闲来垂钓碧溪上，忽复乘舟梦日边。'
                          '行路难！行路难！多歧路，今安在？'
                          '长风破浪会有时，直挂云帆济沧海。',
                      noticeStyle: NoticeStyle(
                          Image(
                            image: const AssetImage("images/notice.png"),
                            width: ScreenUtil().setWidth(16),
                            height: ScreenUtil().setWidth(16),
                            fit: BoxFit.fill,
                          ),
                          const Color(0xFF000000),
                          const Color(0x00FAAD14),
                          BrunoTools.getAssetImage(BrnAsset.iconNoticeArrowOrange)),
                      marquee: true,
                      showRightIcon: false,
                      onNoticeTap: () {
                        BrnToast.show('点击通知', context);
                      },
                      onRightIconTap: () {
                        BrnToast.show('点击右侧图标', context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(16),
                      right: ScreenUtil().setWidth(16),
                      top: ScreenUtil().setWidth(16),
                      bottom: ScreenUtil().setWidth(16),
                    ),
                    child: ExpandableText(
                        text: '大道如青天，我独不得出。'
                            '羞逐长安社中儿，赤鸡白狗赌梨栗。'
                            '弹剑作歌奏苦声，曳裾王门不称情。'
                            '淮阴市井笑韩信，汉朝公卿忌贾生。'
                            '君不见昔时燕家重郭隗，拥篲折节无嫌猜。'
                            '剧辛乐毅感恩分，输肝剖胆效英才。'
                            '昭王白骨萦蔓草，谁人更扫黄金台？'
                            '行路难，归去来！',
                        maxLines: 2,
                        onExpanded: (bool isExpanded) {
                          if (isExpanded) {
                            debugPrint('已经展开');
                          } else {
                            debugPrint('已经收起');
                          }
                        }),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(16),
                        right: ScreenUtil().setWidth(16),
                        top: ScreenUtil().setWidth(16),
                        bottom: ScreenUtil().setWidth(16),
                      ),
                      child: BrnSearchText(
                        controller: _textController,
                        searchController: _searchController,
                        onTextClear: () {
                          return false;
                        },
                        autoFocus: false,
                        hintText: "请输入检索内容",
                        onActionTap: () {
                          _searchController.isClearShow = false;
                          _searchController.isActionShow = false;
                          BrnToast.show('取消', context);
                        },
                        onTextCommit: (text) {
                          BrnToast.show('提交内容 : $text', context);
                        },
                        onTextChange: (text) {
                          // BrnToast.show('输入内容 : $text', context);
                        },
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.removeListener(searchControllerCallBack);
    _textController.removeListener(textControllerCallBack);
    super.dispose();

  }

  //可以滑动的对话框
  void _showScrollDialog() {
    showDialog(
        context: context,
        builder: (_) => BrnScrollableTextDialog(
            title: "纯文本标题纯文",
            isClose: true,
            contentText: "纯本文呢表纯本文呢表纯本文呢表纯本文呢表纯本文呢呢表纯本文呢表纯本文呢"
                "表纯本文呢表纯本文呢呢表纯本文呢表纯本文呢表纯本文呢表纯本文呢呢表"
                "纯本文呢表纯本文呢表纯本文呢表纯本文呢呢表纯本文呢表纯本文呢表纯本"
                "文呢表纯本文呢呢表纯本文呢表纯本文呢表纯本文呢表纯本文呢呢表纯本文呢"
                "表纯本文呢表纯本文呢表纯本文呢呢表纯本文呢表纯本文呢表纯本文呢表纯本"
                "文呢呢表纯本文呢表纯本文呢表纯本文呢表纯本文呢呢表纯本文呢表纯本文呢"
                "表纯本文呢表纯本文呢呢表纯本文呢表纯本文呢表纯本文呢表纯本文呢呢表纯"
                "本文呢表纯本文呢表纯本文呢表纯本文呢呢表纯本文呢表纯本文呢表纯本文呢",
            submitText: "提交",
            onSubmitClick: () {
              BrnToast.show("点击了纯文本弹框", context);
            }));
  }

  void _showBottomDialog() {
    List<BrnCommonActionSheetItem> actions = [];
    actions.add(BrnCommonActionSheetItem(
      '选项一（警示项）',
      actionStyle: BrnCommonActionSheetItemStyle.alert,
    ));
    actions.add(BrnCommonActionSheetItem(
      '选项二',
      actionStyle: BrnCommonActionSheetItemStyle.normal,
    ));
    actions.add(BrnCommonActionSheetItem(
      '选项三',
      actionStyle: BrnCommonActionSheetItemStyle.normal,
    ));

    // 展示actionSheet
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return BrnCommonActionSheet(
            actions: actions,
            cancelTitle: "取消",
            clickCallBack: (
                int index,
                BrnCommonActionSheetItem actionEle,
                ) {
              String title = actionEle.title;
              BrnToast.show("title: $title, index: $index", context);
            },
          );
        });
  }

  void _showDatePicker() {
    String format = 'yyyy年-MM月-dd日';
    BrnDatePicker.showDatePicker(context,
        maxDateTime: DateTime.parse('2030-01-01'),
        minDateTime: DateTime.parse('2020-01-01'),
        initialDateTime: DateTime.parse('2023-05-05'),
        // 支持DateTimePickerMode.date、DateTimePickerMode.datetime、DateTimePickerMode.time
        pickerMode: BrnDateTimePickerMode.date,
        minuteDivider: 30,
        pickerTitleConfig: const BrnPickerTitleConfig(cancel: Text("取消")),
        dateFormat: format, onConfirm: (dateTime, list) {
          BrnToast.show("onConfirm:  $dateTime   $list", context);
        }, onClose: () {
          print("onClose");
        }, onCancel: () {
          print("onCancel");
        }, onChange: (dateTime, list) {
          print("onChange:  $dateTime    $list");
        });
  }

  void _showMultiSelectListPicker() {
    List<BrnMultiSelectBottomPickerItem> items = [];
    items.add(new BrnMultiSelectBottomPickerItem("100", "这里是标题1"));
    items.add(new BrnMultiSelectBottomPickerItem("101", "这里是标题2"));
    items.add(
        new BrnMultiSelectBottomPickerItem("102", "这里是标题3", isChecked: true));
    items.add(
        new BrnMultiSelectBottomPickerItem("103", "这里是标题4", isChecked: true));
    items.add(new BrnMultiSelectBottomPickerItem("104", "这里是标题5"));
    items.add(new BrnMultiSelectBottomPickerItem("104", "这里是标题6"));

    BrnMultiSelectListPicker.show(
      context,
      items: items,
      pickerTitleConfig: BrnPickerTitleConfig(titleContent: "多选 Picker"),
      onSubmit: (List<BrnMultiSelectBottomPickerItem> data) {
        var str = "";
        data.forEach((item) {
          str = str + item.content + "  ";
        });
        BrnToast.show(str, context);
        Navigator.of(context).pop();
      },
    );
  }

  void searchControllerCallBack() {

  }

  void textControllerCallBack() {

  }
}
