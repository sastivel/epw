import 'dart:ffi';

import 'package:EPW_mobile/utils/image_resource.dart';
import 'package:EPW_mobile/utils/string_resource.dart';
import 'package:easy_localization/easy_localization.dart';

class MaterialDetails {
  // create a list for material details.. with multiple objects..
  /// i used this array to display widgets and send the corresponding datas to nxt pages..
  List<dynamic> materialList1 = [
    {
      "image": ImageResource.INTRO_IMAGE,
      "tamil_audio": ImageResource.INTRO_AUDIO_TAMIL,
      "english_audio": ImageResource.INTRO_AUDIO_ENG,
      "tamil_pdf": ImageResource.INTRO_DOC_TAMIL,
      "english_pdf": ImageResource.INTRO_DOC_ENGLISH,
      "name": StringResource.Intro.tr(),
      "tamil_video": ImageResource.INTRO_VIDEO_TAMIL,
      "english_video": ImageResource.INTRO_VIDEO_ENGLISH,
    },
    {
      "image": ImageResource.ALAGE_IMAGE,
      "tamil_audio": ImageResource.ALAGE_AUDIO_TAMIL,
      "english_audio": ImageResource.ALAGE_AUDIO_ENG,
      "tamil_pdf": ImageResource.ALAGE_DOC_TAMIL,
      "english_pdf": ImageResource.ALAGE_DOC_ENGLISH,
      "name": StringResource.Algae.tr(),
      "tamil_video": ImageResource.ALGAE_VIDEO_TAMIL,
      "english_video": ImageResource.ALGAE_VIDEO_ENGLISH,
    },
    {
      "image": ImageResource.FUNGI_IMAGE,
      "tamil_audio": ImageResource.FUNGI_AUDIO_TAMIL,
      "english_audio": ImageResource.FUNGI_AUDIO_ENG,
      "tamil_pdf": ImageResource.FUNGI_DOC_TAMIL,
      "english_pdf": ImageResource.FUNGI_DOC_ENGLISH,
      "name": StringResource.Fungi.tr(),
      "tamil_video": ImageResource.FUNGI_VIDEO_TAMIL,
      "english_video": ImageResource.FUNGI_VIDEO_ENGLISH,
    },
    {
      "image": ImageResource.BYRO_IMAGE,
      "tamil_audio": ImageResource.BYRO_AUDIO_TAMIL,
      "english_audio": ImageResource.BYRO_AUDIO_ENG,
      "tamil_pdf": ImageResource.BYRO_DOC_TAMIL,
      "english_pdf": ImageResource.BYRO_DOC_ENGLISH,
      "name": StringResource.Byro.tr(),
      "tamil_video": ImageResource.BRYO_VIDEO_TAMIL,
      "english_video": ImageResource.BRYO_VIDEO_ENGLISH,
    },
    {
      "image": ImageResource.PTER_IMAGE,
      "tamil_audio": ImageResource.PTER_AUDIO_TAMIL,
      "english_audio": ImageResource.PTER_AUDIO_ENG,
      "tamil_pdf": ImageResource.PTER_DOC_TAMIL,
      "english_pdf": ImageResource.PTERO_DOC_ENGLISH,
      "name": StringResource.Ptero.tr(),
      "tamil_video": ImageResource.PTER_VIDEO_TAMIL,
      "english_video": ImageResource.PTER_VIDEO_ENGLISH,
    },
    {
      "image": ImageResource.GYMNO_IMAGE,
      "tamil_audio": ImageResource.GYMNO_AUDIO_TAMIL,
      "english_audio": ImageResource.GYMNO_AUDIO_ENG,
      "tamil_pdf": ImageResource.GYMNO_DOC_TAMIL,
      "english_pdf": ImageResource.GYMNO_DOC_ENGLISH,
      "name": StringResource.Gymno.tr(),
      "tamil_video": ImageResource.GYMNO_VIDEO_TAMIL,
      "english_video": ImageResource.GYMNO_VIDEO_ENGLISH,
    },
    {
      "image": ImageResource.ANGIO_IMAGE,
      "tamil_audio": ImageResource.ANGIO_AUDIO_TAMIL,
      "english_audio": ImageResource.ANGIO_AUDIO_ENG,
      "tamil_pdf": ImageResource.ANGIO_DOC_TAMIL,
      "english_pdf": ImageResource.ANGIO_DOC_ENGLISH,
      "name": StringResource.Angio.tr(),
      "tamil_video": ImageResource.ANGIO_VIDEO_TAMIL,
      "english_video": ImageResource.ANGIO_VIDEO_ENGLISH,
    },
    {
      "image": ImageResource.FLOWCHART_IMAGE,
      "tamil_audio": null,
      "english_audio": null,
      "tamil_pdf": ImageResource.FLOWCHART_DOC_TAMIL,
      "english_pdf": ImageResource.FLOWCHART_DOC_ENGLISH,
      "name": StringResource.Flowchart.tr(),
      "tamil_video": ImageResource.INTRO_AUDIO_TAMIL,
      "english_video": ImageResource.INTRO_AUDIO_ENG,
      "tamil_video": null,
      "english_video": null,
    }
  ];
}
