import 'package:flutter/material.dart';
import "package:volun/pages/disabled_page.dart";
import "package:volun/pages/env_page.dart";
import "package:volun/pages/society_page.dart";
import "package:volun/pages/wild_page.dart";

String appName = "متطــوع";

const Color redColor = Color.fromARGB(255, 195, 10, 4);
const Color secondaryColor = Color.fromARGB(255, 106, 111, 141);
const Color lightWhiteColor = Color.fromARGB(255, 248, 249, 252);
const Color notActiveColor = Color.fromARGB(255, 106, 111, 141);
const Color activeColor = Color.fromARGB(255, 195, 10, 4);
const Color backgroundColor = Color.fromARGB(255, 248, 249, 252);

List<Widget> homePageItems = [
  const EnvPage(),
  const SocietyPage(),
  const WildPage(),
  const DisabledPage(),
];

String sampleText =
    "تقدم جمعية رسالة الفرصة للمشتركين فى هذا البرنامج بالعمل فى المدن الكبرى كالقاهرة والاسكندرية لزراعة الاشجار واعمار المدينة بالهواء النقى";

String introText = """
نظرا للكوارث الطبيعية التى التى يتعرض لها العالم (أوبئة، حروب، زلازل  ...إلخ) ووقوف دول العالم عاجزة على تخطى هذه الكوارث، كان لزاما على الأفراد ممن لديهم القدرة على العمل التطوعى مشاركة حكوماتهم فى ذلك.
وامتدادا لجهود المستكشفة بيج كينر في َّ منظمة ناشيونال جيوجرافيك فى نشر العمل التطوعى لمكافحة فيرس كرونا ، ومن باب المسئولية الاجتماعية الأساس الذي استندت إليه وزارة البيئة المصرية في إطلاق مبادرتها  Go Green أو  اتحضر للأخضر.
اقدم هذا التطبيق بعنوان متطوع volunteer لجمع بيانات جميع المتطوعين وأنشتطتهم التطوعية ليسهل على الحكومة المصرية فى ظل التحول الرقمى ( الجمهورية الجديدة) توجيههم رقميا تجاه تغير وعى الجماهير وأثناء الكوارث وقت الأزمات.
""";

String toPeople = """






""";

List<String> listPeople = [
  "فخامة الرئيس عبدالفتاح السيسى",
  "د/ رضا حجازى وزير التربية والتعليم",
  "أ/ يوسف الديب وكيل التعليم بالبحيرة",
  "أ/مجدى عبدالمنعم موجه عام الكمبيوتر",
  "أ/علاء داود موجه اول الإدارة",
  "أ/ محمد هيكل منسق IT Academy",
];
